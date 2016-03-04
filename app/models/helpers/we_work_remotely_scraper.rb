class WeWorkRemotelyScraper
  
  def self.scrape_job_list
    data = Nokogiri::HTML(open("https://weworkremotely.com/categories/2-programming/jobs#intro"))
    base = "https://weworkremotely.com"
    data.css("li").map do |job|
      job_link = URI.join(base, job.css("a").attribute("href").value)
      job_hash = {
        company: job.css("a span.company").text,
        location: "Remote",
        position: job.css("a span.title").text,
        seniority: nil,
        job_url: job_link
      }
    end 
  end

  def self.scrape_job_page(job_url)
    data = Nokogiri::HTML(open(job_url))
    company_site = data.css("h2 a")
    company_site.empty? ? company_site = "Not listed." : company_site = company_site.attribute("href").value
    attributes = {
      description: data.css("div.listing-container").text.gsub(/[\n\r]/,""),
      company_site: company_site
    }
  end

  
end