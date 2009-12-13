module DownloadTags
  include Radiant::Taggable

  class TagError < StandardError; end

  desc %{
    Expands if the current reader has any download folders.
    
    <pre><code><r:reader:if_download_folders>...</r:reader:if_download_folders /></code></pre>
  }
  tag "reader:if_download_folders" do |tag|
    %{<p>Test</p>}
  end

  desc %{
    Expands if the current reader does not have any download folders.
    
    <pre><code><r:reader:unless_downloadfolders>...</r:reader:unless_download_folders /></code></pre>
  }
  tag "reader:unless_download_folders" do |tag|
    tag.expand unless tag.locals.reader.download_folders.any?
  end

  desc %{
    Cycles through all download folders for the current reader.
  
    *Usage:* 
    <pre><code><r:reader:download_folders:each>...</r:reader:download_folders:each></code></pre>
  }
  tag 'reader:download_folders' do |tag|
    tag.locals.reader ||= current_reader
    tag.expand if tag.locals.reader
  end
  tag 'reader:download_folders:each' do |tag|
    result = []
    tag.locals.reader.download_folders.each do |download_folder|
      tag.locals.download_folder = download_folder
      result << tag.expand
    end 
    result
  end

  desc %{
    The root 'download' tag is not meant to be called directly. 
    All it does is summon a download object so that its fields can be displayed with eg.
    <pre><code><r:download:url /></code></pre>
  }

  tag 'download' do |tag|
    tag.expand
    tag.locals.download ||= _get_download(tag)
    if tag.locals.download
      tag.expand 
    else
      %{No download found with id '#{tag.attr['id']}' or title '#{tag.attr['title']}'}
    end
  end

  desc %{
    Returns title of current download.

    *Usage:* 
    <pre><code><r:download:title /></code></pre>
  }    
  tag 'download:title' do |tag|
    if download = _get_download(tag)
      download.name 
    end
  end
  tag 'download:name' do |tag|
    if download = _get_download(tag)
      download.name 
    end
  end

  desc %{
    Returns description of current download.

    *Usage:* 
    <pre><code><r:download:description /></code></pre>
  }    
  tag 'download:description' do |tag|
    if download = _get_download(tag)
      download.description 
    end
  end

  desc %{
    Returns the secure url of the current download.

    *Usage:* 
    <pre><code><a href="<r:download:url id="4" />">...</a></code></pre>
  }    
  tag 'download:url' do |tag|
    if download = _get_download(tag)
      download_path(download)
    end
  end

  desc %{
    Returns a link to the current download.
    Attributes and enclosed link text are passed through in the usual way.

    *Usage:* 
    <pre><code><r:download:link /></code></pre>
  }    
  tag 'download:link' do |tag|
    tag.locals.download = _get_download(tag)
    options = tag.attr.dup
    attributes = options.inject('') { |s, (k, v)| s << %{#{k.downcase}="#{v}" } }.strip
    attributes = " #{attributes}" unless attributes.empty?
    text = tag.double? ? tag.expand : tag.render('download:title')
    %{<a href="#{tag.render('download:url')}"#{attributes}>#{text}</a>}
  end
  

private

  def _get_download(tag)
    download = tag.locals.download
    download ||= Download.find_by_id(tag.attr.delete('id')) if tag.attr['id']
    download ||= Download.find_by_title(tag.attr.delete('title')) if tag.attr['title']
    download
  end    

end
