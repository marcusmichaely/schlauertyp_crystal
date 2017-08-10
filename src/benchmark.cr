require "benchmark"
require "http/client"

CONTENT_TYPES = %w(text/plain application/json application/xml text/html)
host, port = (ARGV[0]? || "localhost:3000").split(":")
client = HTTP::Client.new(host, port.to_i)

Benchmark.ips do |x|
  {% for content_type in CONTENT_TYPES %}
    x.report({{ content_type }}) do
      client.get("/", HTTP::Headers{ "Accept" => {{ content_type }} })
    end
  {% end %}
end
