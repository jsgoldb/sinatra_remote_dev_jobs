class AuthenticScraper
  def self.scrape_job_list
    data = Nokogiri::HTML(open("https://authenticjobs.com/#types=7,1,5,4&onlyremote=1"))
    base = "https://authenticjobs.com"
    data.css("ul#listings li[id*='listing']").map do |job|
      if !job.css("a").empty?
        job_link = URI.join(base, job.css("a").attribute('href').value.to_s)
      end
      job_hash = {
        company: job.css("div.details h4").attribute("title").value,
        location: job.css("li.location").text,
        position: job.css("div.details h3").text,
        seniority: nil,
        job_url: job_link
      }
    end 
  end

  def self.scrape_job_page(job_url)
    data = Nokogiri::HTML(open(job_url))
    company_site = data.css("aside a").attribute("href").value
    company_site.empty? ? company_site = "Not listed." : company_site 
    attributes = {
      description: data.css("div.description").text,
      company_site: company_site
    }
  end

  
end