require "json"

class LoadVersesService
  class << self
    def run
      path = Rails.root.join("db/data/kjv.json")
      data = JSON.parse(File.read(path))
      data.each do |hash|
        book = hash["name"]
        hash["chapters"].each_with_index do |array, index|
          chapter_number = index + 1
          array.each_with_index do |verse, verse_index|
            verse_number = verse_index + 1

            Verse.create!(book: book, chapter: chapter_number, number: verse_number, text: verse) rescue nil
          end
        end
      end
    end
  end
end
