require "json"
require "http/server"
require "xml"
require "logger"
require "./message_generator"
require "./resources"
require "kemal"

module SchlauerTyp
  BASE_PATH = {{ env("BASE_PATH") || "/" }}

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

  def self.static_path(file)
    [File.join(BASE_PATH, file), Resources::CACHE_BUSTER].join("?")
  end

  def self.render_html(message, url, io)
    ECR.embed "./templates/message.html.ecr", io
  end

  def self.set_cache_header(response)
    cache_for = 365.days.total_seconds.to_i
    response.headers["Cache-Control"] = "max-age=#{cache_for}, public"
  end

  generator = MessageGenerator.new

  get "/" do |context|
    context.redirect(generator.generate_path)
  end

  get "/:start_index/:middle_index/:end_index" do |context|
    url_params = context.params.url
    message = generator.get_message(
      url_params["start_index"].to_i,
      url_params["middle_index"].to_i,
      url_params["end_index"].to_i
    )

    io = context.response
    case context.request.headers["Accept"]?
    when %r{^text/plain($| )}
      context.response.content_type = "text/plain"
      render_text(message, io)
    when %r{^application/json($| )}
      context.response.content_type = "application/json"
      render_json(message, io)
    when %r{^(text|application)/xml($| )}
      context.response.content_type = "text/xml"
      render_xml(message, io)
    else
      url = "http://#{context.request.host_with_port}#{context.request.path}"
      render_html(message, url, io)
    end

    nil
  end

  get "/styles.css" do |context|
    context.response.content_type = "text/css"
    set_cache_header(context.response)
    ECR.embed("./resources/styles.css.ecr", context.response)
    nil
  end

  {% for resource in [Resources::LOGOS, Resources::FAVICONS] %}
    {% for file, content in resource %}
      get "/{{ file.id }}" do |context|
        set_cache_header(context.response)
        content_type = "image/#{File.extname({{ file }})[1..-1]}"
        content_type += "+xml" if content_type =~ /svg$/
        context.response.content_type = content_type
        {{content}}
      end
    {% end %}
  {% end %}

  Kemal.run
end
