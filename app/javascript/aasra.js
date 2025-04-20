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
    tags: ['Friendly', 'Trained', 'Active']
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
    tags: ['Playful', 'Affectionate']
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
    tags: ['Calm', 'Gentle']
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
    tags: ['Loyal', 'Energetic']
  }
];

// Load Featured Animals
document.addEventListener('DOMContentLoaded', function() {
  // Set current year in footer
  document.getElementById('current-year').textContent = new Date().getFullYear();
  
  // Populate featured animals
  const featuredAnimalsContainer = document.getElementById('featured-animals');
  if (featuredAnimalsContainer) {
    populateFeaturedAnimals(featuredAnimalsContainer, animals);
  }
});

// Function to populate featured animals
function populateFeaturedAnimals(container, animals) {
  animals.forEach(animal => {
    const animalCard = document.createElement('div');
    animalCard.className = 'col-md-6 col-lg-3';
    animalCard.innerHTML = `
      <div class="card h-100 shadow-sm border-0 animal-card">
        <div class="animal-image-container">
          <img src="${animal.image}" alt="${animal.name}" class="animal-image">
          <span class="badge badge-species position-absolute">${animal.species}</span>
        </div>
        
        <div class="card-body">
          <div class="d-flex justify-content-between align-items-start mb-2">
            <div>
              <h3 class="h5 fw-semibold mb-0">${animal.name}</h3>
              <p class="text-secondary small mb-0">${animal.breed}</p>
            </div>
            <span class="badge border badge-gender">${animal.gender}</span>
          </div>
          
          <div class="d-flex align-items-center mt-3 text-secondary small">
            <i class="bi bi-calendar me-2"></i>
            <span>${animal.age}</span>
          </div>
          
          <div class="d-flex align-items-center mt-1 text-secondary small">
            <i class="bi bi-geo-alt me-2"></i>
            <span>${animal.location}</span>
          </div>
          
          ${animal.tags && animal.tags.length > 0 ? `
            <div class="d-flex flex-wrap mt-3">
              ${animal.tags.map(tag => `<span class="badge badge-tag">${tag}</span>`).join('')}
            </div>
          ` : ''}
        </div>
        
        <div class="card-footer bg-white border-top-0 pt-0">
          <div class="d-flex gap-2">
            <a href="animal-details.html?id=${animal.id}" class="btn btn-teal text-white flex-grow-1">
              View Details
            </a>
            <button class="btn btn-outline-orange favorite-btn" data-id="${animal.id}">
              <i class="bi bi-heart"></i>
            </button>
          </div>
        </div>
      </div>
    `;
    container.appendChild(animalCard);
  });

  // Add event listeners to favorite buttons
  document.querySelectorAll('.favorite-btn').forEach(button => {
    button.addEventListener('click', function() {
      const icon = this.querySelector('i');
      if (icon.classList.contains('bi-heart')) {
        icon.classList.remove('bi-heart');
        icon.classList.add('bi-heart-fill');
        this.classList.add('text-orange');
        showToast(`Added ${animals.find(a => a.id === this.dataset.id).name} to favorites!`);
      } else {
        icon.classList.remove('bi-heart-fill');
        icon.classList.add('bi-heart');
        this.classList.remove('text-orange');
        showToast(`Removed from favorites`);
      }
    });
  });
}

// Simple toast notification
function showToast(message) {
  // Create toast element
  const toast = document.createElement('div');
  toast.className = 'position-fixed bottom-0 end-0 p-3';
  toast.style.zIndex = '1050';
  
  toast.innerHTML = `
    <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="toast-header">
        <i class="bi bi-github text-teal me-2"></i>
        <strong class="me-auto">PawsomeRescue</strong>
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
      <div class="toast-body">
        ${message}
      </div>
    </div>
  `;
  
  // Add to document
  document.body.appendChild(toast);
  
  // Remove after 3 seconds
  setTimeout(() => {
    toast.remove();
  }, 3000);
}

// Add additional pages as needed (adopt.html, rescue.html, etc.)
function goTOLogin(){
  window.location.href = "login.html";}
  function goTORegister(){
      window.location.href = "register.html";}
      function goTOAdopt(){
          window.location.href = "adopt.html";}
          function goTORescue(){
              window.location.href = "rescue.html";}
              function goTOShelters(){
                  window.location.href = "shelters.html";}
                  function goTODonate(){
                      window.location.href = "donate.html";}
                      
