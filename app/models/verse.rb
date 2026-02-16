class Verse < ApplicationRecord
  FOOTNOTE_MARKERS = /(Heb\.|Gr\.|Chal\.|Or,|i\.e\.|That is)/

  def self.read(filters)
    where(filters).order(:id)
  end

  # TODO: create a migration to extract footnotes out as a separate table
  # Notes table would be cool
  # Official footnotes would have the boolean footnote: true
  # Personal notes would be false and this table can be used for both footnotes and personal notes
  def parsed_text
    text.gsub(/\{([^}]*)\}/) do
      inner = $1.strip

      # Detect footnote
      if inner.include?(":") ||
         inner.match?(FOOTNOTE_MARKERS) ||
         inner.length > 25
        ""  # remove entirely
      else
        inner  # keep content, remove braces
      end
    end
    .gsub(/\s+/, " ")      # normalize spaces
    .gsub(/\s+([,.;:])/, '\1')  # fix punctuation spacing
    .strip
  end
end
