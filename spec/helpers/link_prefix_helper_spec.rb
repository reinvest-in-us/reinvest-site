require 'spec_helper'

RSpec.describe LinkPrefixHelper do
    include LinkPrefixHelper

    it 'adds http if not prefixed already' do
        expect(prefix('google.com')).to eq 'http://google.com'
        expect(prefix('http://google.com')).to eq 'http://google.com'
        expect(prefix('https://google.com')).to eq 'https://google.com'
    end
end