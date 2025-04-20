// Featured Animals Data (same as in app.js and animal-details.js)
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
    description: 'Max is a friendly and energetic Golden Retriever who loves to play fetch and go on long walks.',
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
    description: 'Whiskers is a sweet and playful tabby cat who loves to cuddle and play with toy mice.',
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
    description: 'Bubbles is a gentle Holland Lop rabbit with soft fur and a calm demeanor.',
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
    description: 'Buddy is an energetic Beagle mix who loves to follow his nose!',
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
      // Update page title
      document.title = `Adopt ${animal.name} - PawsomeRescue`;
      
      // Set animal info in the form
      document.getElementById('animal-id').value = animal.id;
      document.getElementById('animal-name').textContent = animal.name;
      document.getElementById('success-animal-name').textContent = animal.name;
      document.getElementById('animal-image').src = animal.image;
      document.getElementById('animal-image').alt = animal.name;
      document.getElementById('animal-species-breed').textContent = `${animal.species} · ${animal.breed}`;
      document.getElementById('animal-gender-age').textContent = `${animal.gender} · ${animal.age}`;
      
      // Update breadcrumb
      const animalDetailsLink = document.getElementById('animal-details-link');
      animalDetailsLink.textContent = animal.name;
      animalDetailsLink.href = `animal-details.html?id=${animal.id}`;
    } else {
      redirectToAdoptPage();
    }
  } else {
    redirectToAdoptPage();
  }
  
  // Set up form validation and submission
  setupForm();
});

function setupForm() {
  // Show/hide fields based on selection
  document.querySelector('input[name="ownership"]').addEventListener('change', function() {
    const rentSelected = document.getElementById('rent').checked;
    document.getElementById('landlordSection').style.display = rentSelected ? 'block' : 'none';
    if (rentSelected) {
      document.getElementById('landlordContact').setAttribute('required', '');
    } else {
      document.getElementById('landlordContact').removeAttribute('required');
    }
  });
  
  document.querySelector('input[name="hasPets"]').addEventListener('change', function() {
    const hasPets = document.getElementById('petsYes').checked;
    document.getElementById('currentPetsSection').style.display = hasPets ? 'block' : 'none';
    if (hasPets) {
      document.getElementById('currentPets').setAttribute('required', '');
    } else {
      document.getElementById('currentPets').removeAttribute('required');
    }
  });
  
  document.querySelector('input[name="hasChildren"]').addEventListener('change', function() {
    const hasChildren = document.getElementById('childrenYes').checked;
    document.getElementById('childrenAgesSection').style.display = hasChildren ? 'block' : 'none';
    if (hasChildren) {
      document.getElementById('childrenAges').setAttribute('required', '');
    } else {
      document.getElementById('childrenAges').removeAttribute('required');
    }
  });
  
  // Form validation and submission
  const form = document.getElementById('adoption-form');
  
  form.addEventListener('submit', function(event) {
    event.preventDefault();
    
    if (!form.checkValidity()) {
      event.stopPropagation();
      form.classList.add('was-validated');
      // Scroll to the first invalid field
      const firstInvalid = form.querySelector(':invalid');
      if (firstInvalid) {
        firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }
    } else {
      // Show success message
      form.style.display = 'none';
      document.getElementById('success-message').style.display = 'block';
      window.scrollTo({ top: 0, behavior: 'smooth' });
      
      // In a real application, we would send the form data to a server here
      // For this example, we'll just log it to the console
      console.log('Form submitted!', new FormData(form));
    }
  });
}