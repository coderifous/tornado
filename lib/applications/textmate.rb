module Tornado::Applications::Textmate
  def open(*args)
    args.each do |file_path|
      file_path.sub!(/~/, ENV["HOME"])
      app.open(file_path)
    end
  end
end
