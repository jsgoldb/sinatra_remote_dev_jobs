class FlexJobsScraper
  def self.scrape_job_list
    data = Nokogiri::HTML(open("https://www.flexjobs.com/search?accolade=&career_level=Entry-Level&cats%5B%5D=38&country=&exclude=&location=&search=&tele_level=Any+Level+of+Telecommuting&will_travel="))
    base = "https://www.flexjobs.com"
    data.css("li.list-group-item").map do |job|
      if job.css("h5 a").empty? == false
        job_link = URI.join(base, job.css("h5 a").attribute("href").value)
        job_hash = {
          company: nil,
          location: job.css("p.job-type-info").text,
          position: job.css("h5 a").text,
          seniority: "Entry-Level",
          job_url: job_link
        }
      end
    end 
  end

  def self.scrape_job_page(job_url)
    data = Nokogiri::HTML(open(job_url))
    attributes = {
      description: data.css("div#job-description p").text,
      company_site: nil
    }
  end
end