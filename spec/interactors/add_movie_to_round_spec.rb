require 'rails_helper'
require 'hanami/interactor'

RSpec.describe AddMovieToRound do
  describe '#call' do
    let(:tmdb_id) { 123_546_789 }
    let(:round) { create(:round, movie: nil) }

    context 'when the movie already exists in the database' do
      let!(:movie) { create(:movie, tmdb_id: tmdb_id) }

      it "updates the round's movie" do
        expect do
          described_class.new.call(round: round, tmdb_id: tmdb_id)
        end.to change(round, :movie).from(nil).to(movie)
      end
    end

    context 'when the movie does not exist in the database' do
      let(:movie) { create(:movie, tmdb_id: 123) }
      let(:import_service) { double(ImportTmdbMovie) }

      before do
        result_double = double(Hanami::Interactor::Result)
        allow(result_double).to receive(:failure?).and_return(false)
        allow(result_double).to receive(:movie).and_return(movie)
        allow(import_service).to receive(:call).and_return(result_double)
      end

      it "imports the movie and updates the round's movie" do
        expect(import_service).to receive(:call).with(tmdb_movie_id: tmdb_id)

        described_class.new(import_service: import_service).call(round: round, tmdb_id: tmdb_id)

        expect(round.reload.movie).to eq movie
      end
    end
  end
end
