$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'lob'

# initialize Lob object
Lob.api_key = 'test_0dc8d51e0acffcb1880e0f19c79b2f5b0cc'
@lob = Lob.load

html = %{
<html>
<head>
<style>
  *, *:before, *:after {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
  }

  @font-face {
    font-family: 'Loved by the King';
    font-style: normal;
    font-weight: 400;
    src: url('https://s3-us-west-2.amazonaws.com/lob-assets/LovedbytheKing.ttf') format('truetype');
  }

  .text {
    margin-left: 75px;
    padding-top: 250px;
    width: 400px;
    font-family: 'Loved by the King';
    font-size: 50px;
    font-weight: 700;
    color: black;
  }
</style>
</head>

<body>
  <p class="text">Hello {{name}}!<br/><br/>Join us for the {{event}}!</p>
</body>

</html>
}

# create a to address
to_address = @lob.addresses.create(
  name: "ToAddress",
  address_line1: "120 6th Ave",
  city: "Boston",
  state: "MA",
  country: "US",
  zip: 12345
)

# create a from address
from_address = @lob.addresses.create(
  name: "FromAddress",
  address_line1: "120 6th Ave",
  city: "Boston",
  state: "MA",
  country: "US",
  zip: 12345
)

# send the letter
puts @lob.letters.create(
  description: "Test letter",
  to: to_address["id"],
  from: from_address["id"],
  file: html,
  data: { name: 'Albert', event: 'HTML Letter Conference'},
  metadata: { campaign: 'HTML 1.0' },
  color: false
)
