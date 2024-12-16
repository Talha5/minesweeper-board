# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    sequence(:name) { |n| "Test #{n}" }
    sequence(:email) { |n| "email_#{n}@example.com" }
    width { 5 }
    height { 5 }
  end
end
