require 'rails_helper' 

RSpec.describe ImageFacade do 
  it 'creates max 10 image objects based on a country' do 
    images = ImageFacade.images("Laos")
    expect(images).to be_an Array 

    expect(images.count).to be <= 10 

    expect(images[0]).to be_an_instance_of Image 

    expect(images[0].alt_tag).to eq("time lapse photography of flying hot air balloon")
    expect(images[0].url).to eq("https://images.unsplash.com/photo-1540611025311-01df3cef54b5?ixid=MnwzOTk3ODB8MHwxfHNlYXJjaHwxfHxMYW9zfGVufDB8fHx8MTY4MzEzOTMzNA&ixlib=rb-4.0.3")
  
  end

  it 'returns an empty array if no images were found' do 
    images = ImageFacade.images("stevenlalala")

    expect(images).to eq([])
  end
end