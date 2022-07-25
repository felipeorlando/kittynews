require 'rails_helper'

describe Mutations::UserUpdate do
  let!(:user) { create :user, name: 'name' }

  it 'updates the current user' do
    result = call_mutation(current_user: user, name: 'New name')

    expect(result).to eq user: user, errors: []
    expect(user.name).to eq 'New name'
  end

  it 'requires user name' do
    result = call_mutation(current_user: user, name: '')

    expect(result).to eq user: nil, errors: ["Name can't be blank"]
  end

  it 'requires a logged in user' do
    expect { call_mutation(current_user: nil, name: 'Name') }.to raise_error GraphQL::ExecutionError, 'current user is missing'
  end
end
