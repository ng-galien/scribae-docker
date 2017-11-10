#!/usr/bin/env ruby
require 'open3'
require 'rainbow'
require 'git'
require 'yaml'
require 'uri'
require 'bundler/setup'
require 'bundler'



def log(string = nil)
    #puts "verbose: #{@verb}" 
    if !string.nil?
        puts string
    end
end

local_repo = nil

def clone_src()
    data_dir = ENV["DATA_DIR"]
    proj_name = ENV["SCRIBAE_PROJET"]
    Dir.chdir(data_dir)
    log("clone repo")
    return Git.clone("https://github.com/ng-galien/scribae.git", proj_name, :path => data_dir)
end

def generate_files()
    data_dir = ENV["DATA_DIR"]
    proj_name = ENV["SCRIBAE_PROJET"]
    proj_dir = File.join(data_dir, proj_name)
    #directories
    #root
    Dir.chdir(proj_dir)
    dirs = ['posts', '_posts', '_tasks', '_albums', '_story', '_maps', 'css', 'import']
    dirs.each do |dir|
        if !Dir.exist?(dir)
            Dir::mkdir(dir, 0777)
        end  
    end
    #image assets
    asset_img = File.join(proj_dir, 'assets', 'img')
    Dir::mkdir(asset_img, 0777)
    Dir.chdir(asset_img)
    dirs = ['home','post', 'task', 'story', 'albums', 'map']
    dirs.each do |dir|
        if !Dir.exist?(dir)
            Dir::mkdir(dir, 0777)
        end  
    end
    
    #pages
    src_dir = File.join(proj_dir, 'util', 'pages')
    Dir.chdir(src_dir)
    log ":copy_pages in #{Dir.pwd}"
    if Dir.exist?(src_dir)
        Dir.chdir(src_dir)
        pages = Dir.glob("*.{md,html}")
        Dir.chdir(proj_dir)
        pages.each do |page|    
            src = File.join(proj_dir, 'util', 'pages', page)
            dest = File.join(proj_dir, page)
            #specific for posts
            if(page == 'index.html')
                dest = File.join(proj_dir, "posts", page)
            end
            if not File.exist?(dest)
                if File.exist?(src)
                    log "   ->Copy #{dest}"
                    FileUtils.cp(src, dest)
                else
                    log "file #{dest} not found!"
                end
            else
                log "Skip copy,#{dest} already exists"
            end
        end
    end
    #css
    #color
    dest = File.join(proj_dir, '_sass', 'colors.scss')
    src = File.join(proj_dir, 'util', 'scss', 'colors.scss')
    if not File.exist?(dest)
        if File.exist?(src)
            log "Write css theme to #{dest}"
            FileUtils.cp(src, dest)
        else
            log "css not found in #{src}"
        end
    end
    #styles
    nb = 6
    idx = 0
    nb.times do
        name = File.join(proj_dir, 'css', "style-#{idx}.scss")
        style = [
            "---",
            "# Only the main Sass file needs front matter",
            "---",
            "//Import Color",
            "@import \"colors\";",
            "//Define primary colors",
            "$theme_primary: $theme_#{idx}_p;",
            "$theme_secondary: $theme_#{idx}_s;",
            "$theme_background: $theme_#{idx}_b;",
            "$theme_md: $theme_#{idx}_md;",
            "//Import components",
            "@import \"theme\";",
            "@import \"materialize\";",
            "@import \"menu\";",
            "@import \"home\";",
            "@import \"general\";",
        ].join("\n") + "\n"
        File.write(name, style)
        idx += 1
    end
    #configs
    src = File.join(proj_dir, 'util', '_config-default.yml')
    ['_config', '_config_dev'].each do | cfg_name |
        dest = File.join(proj_dir, cfg_name + '.yml')
        FileUtils.cp(src, dest)
    end
end

def check_config()
    data_dir = ENV["DATA_DIR"]
    proj_name = ENV["SCRIBAE_PROJET"]
    proj_dir = File.join(data_dir, proj_name)
    puts Rainbow("Vérification des fichier de config").green
    Dir.chdir(proj_dir)
    #prod
    prod = YAML.load_file('_config.yml')
    prod_url = ENV["SCRIBAE_SITE"]
    if !prod_url.nil? && prod_url.start_with?('http')  
        uri = URI(prod_url)
        prod['url'] = 'http://'+uri.host
        prod['baseurl'] = uri.path
    end
    
    File.open('_config.yml','w') do |h| 
        h.write prod.to_yaml
    end
    #dev
    
    dev = YAML.load_file('_config_dev.yml')
    dev['url'] = ""
    dev['baseurl'] = ""
    dev.store('future' ,true)
    dev.store('local' ,true)
    #dev.store('incremental', true)
    File.open('_config_dev.yml','w') do |h| 
    h.write dev.to_yaml
    end
end

def check_git()
    data_dir = ENV["DATA_DIR"]
    proj_name = ENV["SCRIBAE_PROJET"]
    proj_dir = File.join(data_dir, proj_name)
    puts Rainbow("Vérification du stockage Git").green
end

def start_server()
    data_dir = ENV["DATA_DIR"]
    proj_name = ENV["SCRIBAE_PROJET"]
    proj_dir = File.join(data_dir, proj_name)
    puts Rainbow("Démarrage du serveur").green
end

puts Rainbow("Installateur SCRIBAE").magenta

data_dir = ENV["DATA_DIR"]
proj_name = ENV["SCRIBAE_PROJET"]
proj_dir = File.join(data_dir, proj_name)

puts "Initialisation du projet #{proj_name} dans #{data_dir}"

if Dir.exist?(data_dir)
    
    Dir.chdir(data_dir)
    proj_dir = File.join(data_dir, proj_name)
    log "#{proj_dir}"
    if !Dir.exist?(proj_dir)
        puts Rainbow("Nouveau projet détecté").magenta
        local_repo = clone_src()
        local_repo.config('user.name', 'fakename')
        local_repo.config('user.email', 'fakemail@gmail.com')
        local_repo.remove_remote('origin')
        local_repo.branch('gh-pages').checkout
        generate_files()
        local_repo.add(:all=>true)
        local_repo.commit('Enregistrement initial')
    end
    Dir.chdir(proj_dir)
end

check_config
check_git


