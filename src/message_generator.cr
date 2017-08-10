require "./resources"

module SchlauerTyp
  class MessageGenerator
    START = Resources::MessageData::START
    MIDDLE = Resources::MessageData::MIDDLE
    END = Resources::MessageData::END

    def get_message(start_index, middle_index, end_index)
      "#{START[start_index % START.size]} " \
      "#{MIDDLE[middle_index % MIDDLE.size]} " \
      "#{END[end_index % END.size]}"
    end

    def generate_path
      "/#{rand(START.size)}/#{rand(MIDDLE.size)}/#{rand(END.size)}"
    end
  end
end
