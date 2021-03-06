require 'spec_helper'

describe Lita::Handlers::OnewheelChemex, lita_handler: true do
  it 'will track the age of a chemex pour' do
    send_command 'chemex fresh'
    expect(replies.last).to eq('Fresh chemex is available now!')
  end

  it 'will track the age of a chemex pour' do
    send_command 'chemex fresh'
    send_command 'chemex'
    expect(replies.last).to include('The chemex was brewed at')
  end

  it 'will reset the chemex timer' do
    send_command 'chemex fresh'
    send_command 'chemex reset'
    send_command 'chemex'
    expect(replies.last).to include('There is no chemex.')
  end
end
