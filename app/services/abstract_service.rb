class AbstractService
  def error_messages_for(record)
    record.errors.to_a.join(", ")
  end
end
