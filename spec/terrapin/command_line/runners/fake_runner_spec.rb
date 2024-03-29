require 'spec_helper'

describe Terrapin::CommandLine::FakeRunner do
  it 'records commands' do
    subject.call("some command", :environment)
    subject.call("other command", :other_environment)
    expect(subject.commands).to eq [["some command", :environment], ["other command", :other_environment]]
  end

  it 'can tell if a command was run' do
    subject.call("some command", :environment)
    subject.call("other command", :other_environment)
    expect(subject.ran?("some command")).to eq true
    expect(subject.ran?("no command")).to eq false
  end

  it 'can tell if a command was run even if shell options were set' do
    subject.call("something 2>/dev/null", :environment)
    expect(subject.ran?("something")).to eq true
  end

end
