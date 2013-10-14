require 'spec_helper'

describe RescueTimeApi::Client do

  let(:key){ "B63M14zPRjDUHjN6TNNVydDqe_qGgxCaqUycoIWE" }
  let(:client) { RescueTimeApi::Client.new(key: key) }
  let(:response_data){
    double(body: {
        'row_headers' => [
          "Rank",
          "Time Spent (seconds)",
          "Number of People",
          "Activity",
          "Category",
          "Productivity"
        ],
        'rows' => [
          [1, 5887, 1, "sublime text", "Editing & IDEs", 2],
          [2, 5668, 1, "iTerm", "Systems Operations", 2],
          [3, 4131, 1, "github.com", "General Software Development", 1]
        ]
      })
  }

  context ".new" do

    it "initializes with a key" do
      client = RescueTimeApi::Client.new(key: key)
      expect(client.key).to eq(key)
    end

    it "raises an error without a key" do
      expect {
        client = RescueTimeApi::Client.new({})
      }.to raise_error(KeyError)
    end

    it "knows the host and path by default" do
      client = RescueTimeApi::Client.new(key: key)
      expect(client.host).to eq("www.rescuetime.com")
      expect(client.base_path).to eq("/anapi/data")
    end

  end

  context "#connection" do

    let(:client) { RescueTimeApi::Client.new(key: key) }

    it "creates a @connection" do
      expect(client.instance_variable_get(:@connection)).to eq(nil)
      client.connection
      expect(client.instance_variable_get(:@connection)).to be_a(Faraday::Connection)
    end

  end

  context "#run_request" do

    it "sends the request to the connection, adding the base path and default parameters" do
      connection = double()
      expect(connection).to receive(:get).with("/anapi/data", {
        key: key,
        format: 'json',
        perspective: 'interval'
      })
      client.stub(:connection).and_return(connection)
      client.run_request({perspective: 'interval'})
    end

  end

  context "#request" do

    it "sends the request to the #run_request, formatting any date parameters" do
      stamp = DateTime.now.strftime('%Y-%m-%d')

      expect(client).to receive(:run_request).with({
        re: stamp
      })

      client.request({re: DateTime.now})

    end

    it "returns a Response object" do

      client.stub(:run_request).and_return(response_data)
      expect(client.request({})).to be_a(RescueTimeApi::Response)
      expect(client.request({}).rows.count).to eq(3)

    end

  end


end