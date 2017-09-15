module ApplicationHelper

  def get_countries
    Country.all.map{|c| ["#{c.name}", c.id] }
  end

  def get_cities
    City.all.map{|c| ["#{c.name}", c.id] }
  end

  def get_active_users
    User.active.map{|c| ["#{c.email} - #{c.full_name}", c.id] }
  end

  def get_users
    User.all.map{|c| ["#{c.email} - #{c.full_name}", c.id] }
  end

  def get_admins
    Admin.all.map{|c| ["#{c.email} - #{c.full_name}", c.id] }
  end

  def get_audit_users
    [[t('activerecord.models.admin'), 'Admin'], [t('activerecord.models.user'), 'User']]
  end

  def paginate(collection)
    content_tag(:div, class: 'pagination pagination-sm') do
      will_paginate collection, renderer: BootstrapPagination::Rails, bootstrap: 3
    end
  end
end
