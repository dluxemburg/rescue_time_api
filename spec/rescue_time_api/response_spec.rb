require 'spec_helper'

describe RescueTimeApi::Response do

  let(:response_headers){
    double()
  }
  let(:response_body){
    {
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
      }
  }
  let(:response_body2){
    {
        'row_headers' => [
           "Date",
           "Time Spent (seconds)",
           "Number of People",
           "Activity",
           "Category",
           "Productivity"
         ],
        'rows' => [
          [
            "2013-10-14T00:00:00",
            136,
            1,
            "github.com",
            "General Software Development",
            1
          ]
        ]
      }
  }
  let(:response_object){
    double(body: response_body, headers: response_headers)
  }
  let(:response_object2){
    double(body: response_body2, headers: response_headers)
  }
  let(:response){ RescueTimeApi::Response.new(response_object) }
  let(:response2){ RescueTimeApi::Response.new(response_object2) }

  it "maps raw response body to an array of hashes" do

    expect(response.rows).to be_a(Array)
    expect(response.rows.map(&:class)).to eq [Hash,Hash,Hash]

  end

  it "ensures integer values are Integers" do

    expect(response.rows.first['rank']).to be_a(Integer)
    expect(response.rows.first['seconds']).to be_a(Integer)
    expect(response.rows.first['people']).to be_a(Integer)
    expect(response.rows.first['productivity']).to be_a(Integer)

  end

  it "ensures date values are DateTimes" do

    expect(response2.rows.first['date']).to be_a(DateTime)

  end

  it "exposes the original reponse object" do
    expect(response.response).to eq(response_object)
  end

  it "exposes the original headers object" do
    expect(response.headers).to eq(response_headers)
  end

end