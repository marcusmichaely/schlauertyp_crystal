module SchlauerTyp
  class MessageGenerator
    START = {{ run("./load_yaml", "./resources/message_parts.yml", "start") }}
    MIDDLE = {{ run("./load_yaml", "./resources/message_parts.yml", "middle") }}
    END = {{ run("./load_yaml", "./resources/message_parts.yml", "end") }}

    def generate_message
      "#{START.sample} #{MIDDLE.sample} #{END.sample}"
    end
  end
end
