FactoryBot.define do
  factory :invitation do
    invitee factory: :user
    inviter factory: :user
    team
  end
end
