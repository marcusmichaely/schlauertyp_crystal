require "json"
require "http/server"
require "xml"
require "logger"
require "./message_generator"

module SchlauerTyp
  def self.render_text(message, io)
    io.puts(message)
  end

  def self.render_json(message, io)
    json_builder = JSON::Builder.new(io)
    json_builder.document do
      json_builder.object do
        json_builder.field("message", message)
      end
    end
  end

  def self.render_xml(message, io)
    xml_builder = XML::Builder.new(io)
    xml_builder.document(encoding: "utf-8") do
      xml_builder.element("message") do
        xml_builder.text(message)
      end
    end
  end

  def self.render_html(message, io)
    ECR.embed "./templates/message.html.ecr", io
  end

  host, port = (ARGV[0]? || "localhost:3000").split(":")
  generator = MessageGenerator.new

  server = HTTP::Server.new(host, port.to_i) do |context|
    message = generator.generate_message
    io = context.response
    case context.request.headers["Accept"]?
    when %r{^text/plain($| )} then render_text(message, io)
    when %r{^application/json($| )} then render_json(message, io)
    when %r{^(text|application)/xml($| )} then render_xml(message, io)
    else render_html(message, io)
    end
  end

  puts "Listening on #{host}:#{port}"
  server.listen
end
