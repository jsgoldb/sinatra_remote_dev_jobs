class StackScraper
  def self.scrape_job_list
    data = Nokogiri::HTML(open("http://careers.stackoverflow.com/jobs?searchTerm=junior&allowsremote=true"))
    base = "http://careers.stackoverflow.com"
    data.css("div.-item.-job").map do |job|
      job_link = URI.join(base, job.css("h1 .job-link").attribute('href').value.to_s)
      job_page = Nokogiri::HTML(open("#{job_link}"))
      seniority = job_page.css("li.seniority").text
      seniority.empty? ?  seniority = nil : seniority = seniority.split("\r\n")[1].split(" ").join(" ")
      job_hash = {
        company: job.css("ul li.employer").text.split("\r")[1].split(" ").join(" "),
        location: job.css("ul li.location").text.split("\r\n")[1].split(" ").join(" "),
        position: job.css("a.job-link").attribute("title").value,
        seniority: seniority,
        job_url: job_link
      }
    end 
  end

  def self.scrape_job_page(job_url)
    data = Nokogiri::HTML(open(job_url))
    company_site = data.css("a.employer.up-and-out")
    company_site.empty? ? company_site = "Not listed." : company_site = company_site.attribute("href").value.to_s
    attributes = {
      description: data.css("div.description p").text,
      company_site: company_site
    }
  end
end