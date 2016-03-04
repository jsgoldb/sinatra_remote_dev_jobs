class JobsController < ApplicationController

  get '/stackcareers' do
    @jobs = StackScraper.scrape_job_list
    @site = 'stackcareers'
    erb :'jobs/index'
  end

  get '/stackcareers/:id' do
    @job = StackScraper.scrape_job_list.find do |job|
      job if job[:company].slugify == params[:id] 
    end

    @job_info = StackScraper.scrape_job_page(@job[:job_url])
    erb :'jobs/show'
  end

  get '/flexjobs' do
    @jobs = FlexJobsScraper.scrape_job_list
    @site = 'flexjobs'
    erb :'jobs/index'
  end

  get '/flexjobs/:id' do
    @job = FlexJobsScraper.scrape_job_list.find do |job|
      job if job[:company].slugify == params[:id] 
    end

    @job_info = FlexJobsScraper.scrape_job_page(@job[:job_url])
    erb :'jobs/show'
  end

  get '/weworkremotely' do
    @jobs = WeWorkRemotelyScraper.scrape_job_list
    @site = 'weworkremotely'
    erb :'jobs/index'
  end

  get '/weworkremotely/:id' do
    @job = WeWorkRemotelyScraper.scrape_job_list.find do |job|
      job if job[:company].slugify == params[:id] 
    end

    @job_info = WeWorkRemotelyScraper.scrape_job_page(@job[:job_url])
    erb :'jobs/show'
  end

  get '/authenticjobs' do
    @jobs = AuthenticScraper.scrape_job_list
    @site = 'authenticjobs'
    erb :'jobs/index'
  end

  get '/authenticjobs/:id' do
    @job = AuthenticScraper.scrape_job_list.find do |job|
      job if job[:company].slugify == params[:id] 
    end

    @job_info = AuthenticScraper.scrape_job_page(@job[:job_url])
    erb :'jobs/show'
  end

end