class VersesController < ApplicationController
  def read
    @verses = Verse.read(filters)
    @next_cursor = @verses.last&.id
  end

  def next_read
    verse_id = params[:verse_id]
    limit = 100 || params[:limit].to_i
    stay_in_current_book = params[:stay_in_current_book].presence

    current_verse = Verse.find(verse_id)

    raise 'Verse not found' if current_verse.blank?

    @verses = Verse.where({id: (current_verse.id+1)..(current_verse.id + limit), book: stay_in_current_book}.compact_blank)
    @next_cursor = @verses.last&.id

    respond_to do |format|
      format.turbo_stream    
    end
  end

  private

  def filters
    permitted = params.permit(:book, :chapter, :verse, :verse_start, :verse_end)

    {
      book: permitted[:book].presence || "John",
      chapter: permitted[:chapter]&.to_i,
      number: verse_range(permitted)
    }.compact_blank
  end

  def verse_range(p)
    return nil unless p[:chapter].present?
    return p[:verse].to_i if p[:verse].present?
    return nil unless p[:verse_start].present? && p[:verse_end].present?

    p[:verse_start].to_i..p[:verse_end].to_i
    
  end
end
