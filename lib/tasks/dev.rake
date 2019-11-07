if Rails.env.development? || Rails.env.staging?
  namespace :dev do
    desc "Seed data for development environment"
    task prime: "db:setup" do
      include FactoryBot::Syntax::Methods

      create(:user, first_name: "John", last_name: "Wayne")
    end
  end
end
