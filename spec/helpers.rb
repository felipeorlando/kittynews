module Helpers
  def call_mutation(current_user:, context: {}, **args)
    context = Utils::Context.new(
      query: OpenStruct.new(schema: KittynewsSchema),
      values: context.merge(current_user: current_user),
      object: nil,
    )
    described_class.new(object: nil, context: context, field: nil).resolve(args)
  end

  def login(email:, password:)
    visit root_path
    click_on 'Login'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end

  def logout
    click_on 'Logout'
  end
end