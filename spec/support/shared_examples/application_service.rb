RSpec.shared_examples "service failure" do |error|
  it "raises error" do
    expect(result).to be_failure
    expect(result.payload).to be_nil
    expect(result.error).to be_a(error)
  end
end
