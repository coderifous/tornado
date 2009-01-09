module Tornado::Applications::Textmate
  def open(*args)
    args.each do |file_path|
      file_path.sub!(/~/, ENV["HOME"])
      app.open(file_path)
    end
  end
end

# in case I jack up textmate's drawer again:
# defaults write com.macromates.textmate OakProjectDrawerWidth 100
