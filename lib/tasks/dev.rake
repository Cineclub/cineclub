if Rails.env.development? || Rails.env.staging?
  namespace :dev do
    desc "Seed data for development environment"
    task prime: "db:setup" do
      User.create(
        first_name: "John",
        last_name: "Wayne",
        email: "john@example.org",
        password: "stagecoach"
      )
    end
  end
end
