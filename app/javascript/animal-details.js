// Featured Animals Data (same as in app.js)
const animals = [
  {
    id: '1',
    name: 'Max',
    species: 'Dog',
    breed: 'Golden Retriever',
    age: '2 years',
    gender: 'Male',
    location: 'Main Shelter',
    image: 'https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&auto=format&fit=crop&w=640&q=80',
    tags: ['Friendly', 'Trained', 'Active'],
    description: 'Max is a friendly and energetic Golden Retriever who loves to play fetch and go on long walks. He\'s good with children and other dogs. He\'s been trained for basic commands and is looking for an active family who can give him the exercise and attention he needs.',
    medicalInfo: 'Vaccinations up to date, neutered, microchipped',
    behavior: 'Good with children, good with other dogs, leash trained, house trained',
    adoptionFee: '$250'
  },
  {
    id: '2',
    name: 'Whiskers',
    species: 'Cat',
    breed: 'Tabby',
    age: '1 year',
    gender: 'Female',
    location: 'Foster Home',
    image: 'https://images.unsplash.com/photo-1582562124811-c09040d0a901?ixlib=rb-4.0.3&auto=format&fit=crop&w=640&q=80',
    tags: ['Playful', 'Affectionate'],
    description: 'Whiskers is a sweet and playful tabby cat who loves to cuddle and play with toy mice. She\'s very affectionate and will often curl up in your lap while you read or watch TV. She gets along well with other cats but may need time to adjust to dogs.',
    medicalInfo: 'Vaccinations up to date, spayed, microchipped',
    behavior: 'Good with cats, shy around dogs, litter trained',
    adoptionFee: '$150'
  },
  {
    id: '3',
    name: 'Bubbles',
    species: 'Rabbit',
    breed: 'Holland Lop',
    age: '6 months',
    gender: 'Female',
    location: 'Main Shelter',
    image: 'https://images.unsplash.com/photo-1535241749838-299277b6305f?ixlib=rb-4.0.3&auto=format&fit=crop&w=640&q=80',
    tags: ['Calm', 'Gentle'],
    description: 'Bubbles is a gentle Holland Lop rabbit with soft fur and a calm demeanor. She enjoys being pet and will contentedly munch on fresh vegetables while sitting in your lap. She\'s litter trained and would make a great indoor companion.',
    medicalInfo: 'Vaccinations up to date, spayed',
    behavior: 'Calm temperament, litter trained, good with gentle handling',
    adoptionFee: '$85'
  },
  {
    id: '4',
    name: 'Buddy',
    species: 'Dog',
    breed: 'Beagle Mix',
    age: '4 years',
    gender: 'Male',
    location: 'Downtown Shelter',
    image: 'https://images.unsplash.com/photo-1568640347023-a616a30bc3bd?ixlib=rb-4.0.3&auto=format&fit=crop&w=640&q=80',
    tags: ['Loyal', 'Energetic'],
    description: 'Buddy is an energetic Beagle mix who loves to follow his nose! He\'s a loyal companion who bonds closely with his humans. He enjoys running in the yard and playing fetch. He would do best in a home with a fenced yard where he can safely explore.',
    medicalInfo: 'Vaccinations up to date, neutered, microchipped',
    behavior: 'Energetic, needs regular exercise, basic training',
    adoptionFee: '$200'
  }
];

document.addEventListener('DOMContentLoaded', function() {
  // Set current year in footer
  document.getElementById('current-year').textContent = new Date().getFullYear();
  
  // Get animal ID from URL
  const urlParams = new URLSearchParams(window.location.search);
  const animalId = urlParams.get('id');
  
  if (animalId) {
    // Find animal by ID
    const animal = animals.find(a => a.id === animalId);
    
    if (animal) {
      // Update page title and breadcrumb
      document.title = `${animal.name} - PawsomeRescue`;
      document.getElementById('animal-name-breadcrumb').textContent = animal.name;
      
      // Render animal details
      renderAnimalDetails(animal);
      
      // Get related animals (same species, different ID)
      const relatedAnimals = animals.filter(a => a.species === animal.species && a.id !== animal.id);
      renderRelatedAnimals(relatedAnimals);
    } else {
      renderAnimalNotFound();
    }
  } else {
    renderAnimalNotFound();
  }
});

function renderAnimalDetails(animal) {
  const container = document.getElementById('animal-details-container');
  
  container.innerHTML = `
    <div class="row g-4">
      <div class="col-lg-6">
        <div class="rounded-3 overflow-hidden shadow-sm">
          <img src="${animal.image}" alt="${animal.name}" class="img-fluid w-100" style="height: 400px; object-fit: cover;">
        </div>
        <div class="mt-3 d-flex flex-wrap gap-2">
          <button class="btn btn-outline-orange d-flex align-items-center gap-2" id="wishlist-button">
            <i class="bi bi-heart" id="wishlist-heart-icon"></i> Add to Wishlist
          </button>
          <button class="btn btn-outline-teal d-flex align-items-center gap-2">
            <i class="bi bi-share"></i> Share
          </button>
        </div>
      </div>
      
      <div class="col-lg-6">
        <div class="d-flex align-items-center mb-3">
          <h1 class="h2 fw-bold mb-0">${animal.name}</h1>
          <span class="badge rounded-pill bg-orange ms-3">${animal.species}</span>
        </div>
        
        <div class="row g-3 mb-4">
          <div class="col-6 col-md-3">
            <div class="bg-light rounded p-3 text-center">
              <div class="small text-secondary">Breed</div>
              <div class="fw-semibold">${animal.breed}</div>
            </div>
          </div>
          <div class="col-6 col-md-3">
            <div class="bg-light rounded p-3 text-center">
              <div class="small text-secondary">Age</div>
              <div class="fw-semibold">${animal.age}</div>
            </div>
          </div>
          <div class="col-6 col-md-3">
            <div class="bg-light rounded p-3 text-center">
              <div class="small text-secondary">Gender</div>
              <div class="fw-semibold">${animal.gender}</div>
            </div>
          </div>
          <div class="col-6 col-md-3">
            <div class="bg-light rounded p-3 text-center">
              <div class="small text-secondary">Location</div>
              <div class="fw-semibold">${animal.location}</div>
            </div>
          </div>
        </div>
        
        <h3 class="h5 fw-semibold">About ${animal.name}</h3>
        <p>${animal.description}</p>
        
        <div class="mb-4">
          <h3 class="h5 fw-semibold">Details</h3>
          <div class="row g-3">
            <div class="col-md-6">
              <div class="d-flex align-items-center mb-2">
                <i class="bi bi-clipboard2-pulse me-2 text-teal"></i>
                <span class="fw-semibold">Medical Information</span>
              </div>
              <p class="small text-secondary">${animal.medicalInfo}</p>
            </div>
            <div class="col-md-6">
              <div class="d-flex align-items-center mb-2">
                <i class="bi bi-person-check me-2 text-teal"></i>
                <span class="fw-semibold">Behavior & Training</span>
              </div>
              <p class="small text-secondary">${animal.behavior}</p>
            </div>
          </div>
        </div>
        
        <div class="card bg-light border-0 p-4 mb-4">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <h3 class="h5 fw-semibold mb-0">Adoption Fee</h3>
              <p class="small text-secondary mb-0">Includes vaccinations, spay/neuter, microchip</p>
            </div>
            <div class="h3 fw-bold text-teal mb-0">${animal.adoptionFee}</div>
          </div>
        </div>
        
        <a href="adopt-form.html?id=${animal.id}" class="btn btn-teal text-white btn-lg w-100">
          Apply to Adopt ${animal.name}
        </a>
      </div>
    </div>
  `;

  // Wishlist button functionality
  const wishlistButton = document.getElementById('wishlist-button');
  const wishlistHeartIcon = document.getElementById('wishlist-heart-icon');
  
  wishlistButton.addEventListener('click', function() {
    if (wishlistHeartIcon.classList.contains('bi-heart-fill')) {
      wishlistHeartIcon.classList.remove('bi-heart-fill');
      wishlistHeartIcon.classList.add('bi-heart');
      wishlistButton.textContent = 'Add to Wishlist';
    } else {
      wishlistHeartIcon.classList.remove('bi-heart');
      wishlistHeartIcon.classList.add('bi-heart-fill');
      wishlistButton.textContent = 'Remove from Wishlist';
    }
  });
}

function renderRelatedAnimals(animals) {
  const container = document.getElementById('related-animals-container');
  
  container.innerHTML = `
    <h3 class="h5 fw-semibold">Related Animals</h3>
    <div class="row g-4">
      ${animals.map(animal => `
        <div class="col-lg-3 col-md-4 col-sm-6">
          <div class="card shadow-sm rounded">
            <img src="${animal.image}" class="card-img-top" alt="${animal.name}">
            <div class="card-body">
              <h5 class="card-title">${animal.name}</h5>
              <p class="card-text">${animal.breed}</p>
              <a href="animal-details.html?id=${animal.id}" class="btn btn-teal stretched-link">View Details</a>
            </div>
          </div>
        </div>
      `).join('')}
    </div>
  `;
}

function renderAnimalNotFound() {
  const container = document.getElementById('animal-details-container');
  container.innerHTML = '<h3 class="text-center">Animal not found</h3>';
}
