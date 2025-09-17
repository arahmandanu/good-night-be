class AbstractService
  def error_messages_for(record)
    record.errors.to_a.join(", ")
  end

  def build_paginate_response(relation)
    {
      data: relation,
      meta: {
        total_pages: relation.total_pages,
        current_page: relation.current_page,
        next_page: relation.next_page,
        prev_page: relation.prev_page,
        total_count: relation.total_count
      }
    }
  end
end
