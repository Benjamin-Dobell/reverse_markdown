require 'spec_helper'

describe ReverseMarkdown::Converters::Del do
  let(:converter) { ReverseMarkdown::Converters::Del.new }

  context 'with github_flavored = true' do
    before { ReverseMarkdown.config.github_flavored = true }

    it 'converts the input as expected' do
      input = Nokogiri::XML.parse('<del>deldeldel</del>').root
      expect(converter.convert(input)).to eq '~~deldeldel~~'
    end

    it 'skips empty tags' do
      input = Nokogiri::XML.parse('<del></del>').root
      expect(converter.convert(input)).to eq ''
    end

    it 'knows about its enabled/disabled state' do
      expect(converter).to be_enabled
      expect(converter).not_to be_disabled
    end
  end

  context 'with github_flavored = false' do
    before { ReverseMarkdown.config.github_flavored = false }

    it 'does not convert anything' do
      input = Nokogiri::XML.parse('<del>deldeldel</del>').root
      expect(converter.convert(input)).to eq 'deldeldel'
    end

    it 'knows about its enabled/disabled state' do
      expect(converter).not_to be_enabled
      expect(converter).to be_disabled
    end
  end
end
