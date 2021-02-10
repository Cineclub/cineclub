require 'rails_helper'
require 'hanami/interactor'

RSpec.describe AddMovieToRound do
  subject { described_class.new(round: round, tmdb_id: tmdb_id).call }

  describe '#call' do
    let(:tmdb_id) { 123_546_789 }
    let(:round) { create(:round, movie: nil) }

    context 'when the movie already exists in the database' do
      let!(:movie) { create(:movie, tmdb_id: tmdb_id) }

      it "updates the round's movie" do
        expect { subject }.to change(round, :movie).from(nil).to(movie)
      end
    end

    context 'when the movie does not exist in the database' do
      let(:movie) { create(:movie, tmdb_id: 123) }

      before do
        result_double = double(Hanami::Interactor::Result)

        allow(ImportTmdbMovie).to receive_message_chain(:new, :call).and_return(result_double)
        allow(result_double).to receive(:failure?).and_return(false)
        allow(result_double).to receive(:movie).and_return(movie)
      end

      it "imports the movie and updates the round's movie" do
        expect(ImportTmdbMovie).to receive_message_chain(:new, :call).with(tmdb_movie_id: tmdb_id)
        subject
        expect(round.reload.movie).to eq movie
      end
    end
  end
end
