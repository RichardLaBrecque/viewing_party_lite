require 'rails_helper'

RSpec.describe StreamingFacade do
  xit 'returns an array', :vcr do
    links = StreamingFacade.streaming_links("tt6264654")
    expect(links).to be_a Array

  end
end
