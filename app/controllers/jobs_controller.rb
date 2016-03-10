class JobsController < ApplicationController

  get '/stackcareers' do
    @jobs = StackScraper.scrape_job_list.compact
    @jobs = @jobs.select {|job| job[:position] != ''}
    @site = 'stackcareers'
    erb :'jobs/index'
  end

  get '/stackcareers/:id' do
    @job = StackScraper.scrape_job_list.find do |job|
      job if job[:company].slugify == params[:id] 
    end

    @job_info = StackScraper.scrape_job_page(@job[:job_url])

    @current_job = Job.find_or_create_by(company: @job[:company], 
      position: @job[:position], location: @job[:location],
      description: @job_info[:description], job_url: @job[:job_url].to_s,
      seniority: @job[:seniority], company_site: @job_info[:company_site])
    @user = current_user
    @notes = user_job_notes(@user.jobs)
    @site = 'stackcareers'
    erb :'jobs/show'
  end

  get '/flexjobs' do
    @jobs = FlexJobsScraper.scrape_job_list.compact
    @jobs = @jobs.select {|job| job[:position] != ''}
    @site = 'flexjobs'
    erb :'jobs/index'
  end

  get '/flexjobs/:id' do
    @job = FlexJobsScraper.scrape_job_list.find do |job|
      job if job[:position].slugify == params[:id] 
    end
    @job_info = FlexJobsScraper.scrape_job_page(@job[:job_url])

    @current_job = Job.find_or_create_by(position: @job[:position], location: @job[:location],
      description: @job_info[:description], job_url: @job[:job_url].to_s,
      seniority: @job[:seniority])
    @user = current_user
    @notes = user_job_notes(@user.jobs)
    @site = 'flexjobs'
    erb :'jobs/show'
  end

  get '/weworkremotely' do
    @jobs = WeWorkRemotelyScraper.scrape_job_list.compact
    @jobs = @jobs.select {|job| job[:position] != ''}
    @site = 'weworkremotely'
    erb :'jobs/index'
  end

  get '/weworkremotely/:id' do
    @job = WeWorkRemotelyScraper.scrape_job_list.find do |job|
      job if job[:company].slugify == params[:id] 
    end

    @job_info = WeWorkRemotelyScraper.scrape_job_page(@job[:job_url])

    @current_job = Job.find_or_create_by(company: @job[:company], 
      position: @job[:position], location: @job[:location],
      description: @job_info[:description], job_url: @job[:job_url].to_s,
      seniority: @job[:seniority], company_site: @job_info[:company_site])
    @user = current_user
    @notes = user_job_notes(@user.jobs)
    @site = 'weworkremotely'
    erb :'jobs/show'
  end

  get '/authenticjobs' do
    @jobs = AuthenticScraper.scrape_job_list.compact
    @jobs = @jobs.select {|job| job[:position] != ''}
    @site = 'authenticjobs'
    erb :'jobs/index'
  end

  get '/authenticjobs/:id' do
    @job = AuthenticScraper.scrape_job_list.find do |job|
      job if job[:company].slugify == params[:id] 
    end

    @job_info = AuthenticScraper.scrape_job_page(@job[:job_url])

    @current_job = Job.find_or_create_by(company: @job[:company], 
      position: @job[:position], location: @job[:location],
      description: @job_info[:description], job_url: @job[:job_url].to_s,
      seniority: @job[:seniority], company_site: @job_info[:company_site])

    @user = current_user
    @notes = user_job_notes(@user.jobs)
    @site = 'authenticjobs'
    erb :'jobs/show'
  end

end