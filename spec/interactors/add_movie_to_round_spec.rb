require 'rails_helper'

RSpec.describe AddMovieToRound do
  let(:import_tmdb_movie_interactor) { instance_double(ImportTmdbMovie, 'import_tmdb_movie_interactor') }
  subject { AddMovieToRound.new(import_tmdb_movie_interactor: import_tmdb_movie_interactor) }

  describe '#call' do
    let(:tmdb_movie_id) { 123_456_789 }
    let(:round) { build(:round) }

    context 'when a movie with `tmdb_movie_id` already exists in the database' do
      before { create(:movie, tmdb_id: tmdb_movie_id) }

      it "sets the round's movie to the one with `tmdb_movie_id`" do
        result = subject.call(round: round, tmdb_movie_id: tmdb_movie_id)

        expect(result).to be_successful
        expect(result.round.id).to eq(round.id)
        expect(round.movie.reload.tmdb_id).to eq(tmdb_movie_id)
      end
    end

    context "when a movie with `tmdb_movie_id` doesn't exist in the database" do
      before do
        allow(import_tmdb_movie_interactor).to receive(:call) do
          created_movie = create(:movie, tmdb_id: tmdb_movie_id)

          import_result_double = double('import_result')
          allow(import_result_double).to receive(:successful?).and_return(true)
          allow(import_result_double).to receive(:movie).and_return(created_movie)

          import_result_double
        end
      end

      it "imports the movie and updates the round's movie" do
        expect(import_tmdb_movie_interactor).to receive(:call).with(tmdb_movie_id: tmdb_movie_id)

        result = subject.call(round: round, tmdb_movie_id: tmdb_movie_id)

        expect(result.round.id).to eq(round.id)
        expect(round.movie.reload.tmdb_id).to eq(tmdb_movie_id)
      end
    end
  end
end
