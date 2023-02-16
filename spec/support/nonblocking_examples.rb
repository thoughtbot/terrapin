shared_examples_for "a command that does not block" do
  it 'does not block if the command outputs a lot of data' do
    garbage_file = Tempfile.new("garbage")
    10.times{ garbage_file.write("A" * 1024 * 1024) }

    Timeout.timeout(5) do
      output = subject.call("cat '#{garbage_file.path}'")
      expect($?.exitstatus).to eq(0)
      expect(output.output.length).to eq(10 * 1024 * 1024)
    end

    garbage_file.close
  end
end
