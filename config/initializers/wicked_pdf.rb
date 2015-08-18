if Rails.env.production?
  wkhtmltopdf_path = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s
else
  wkhtmltopdf_path = "/home/webwerks/.rvm/gems/ruby-2.0.0-p643/bin/wkhtmltopdf"
end

WickedPdf.config = { exe_path: wkhtmltopdf_path, wkhtmltopdf: wkhtmltopdf_path }