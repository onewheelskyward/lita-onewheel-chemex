require 'spec_helper'

describe Lita::Handlers::OnewheelChemex, lita_handler: true do
  it 'will track the age of a chemex pour' do
    send_command 'chemex fresh'
    expect(replies.last).to eq('Fresh chemex is available now!')
  end
  # it 'will track the age of a chemex pour' do
  #   send_command 'chemex'
  #   expect(replies.last).to eq('The chemex is x seconds old.')
  # end
end
