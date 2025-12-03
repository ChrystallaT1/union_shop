# Union Shop App Requirements

## Basic Features (40%)

### 1. Static Homepage

**Weight:** 5%

#### Description

A homepage that serves as the landing page for the Union Shop app, displaying static content including shop branding, featured products, and navigation options. The layout should be mobile-friendly and provide a welcoming interface for users.

#### User Stories

- As a customer, I want to see the shop's branding and featured products when I open the app so that I can quickly understand what the shop offers.
- As a mobile user, I want the homepage to be responsive so that I can view it comfortably on my phone.
- As a customer, I want to see clear navigation options so that I can easily explore different sections of the shop.

#### Acceptance Criteria

- [✅] Homepage displays the "UPSU Union Shop" branding prominently
- [✅] Homepage includes at least 3-4 featured product sections with hardcoded data
- [✅] Layout is responsive and adapts to mobile view
- [✅] Navigation bar is visible and accessible
- [✅] Page loads without errors
- [✅] All static content is properly formatted and readable

---

### 2. About Us Page

**Weight:** 5%

#### Description

A separate informational page that provides details about the Union Shop, its purpose as a coursework project, and relevant disclaimers. This page should be accessible from the main navigation.

#### User Stories

- As a visitor, I want to read about the shop's purpose so that I understand it's a coursework project.
- As a user, I want to access the About Us page from any page in the app so that I can learn more about the shop.
- As a course evaluator, I want to see clear disclaimers about the app being for educational purposes.

#### Acceptance Criteria

- [✅] About Us page is accessible via navigation bar
- [✅] Page includes sections for Purpose, Goals, and Disclaimer
- [✅] Content is well-formatted with proper headings and spacing
- [✅] Page uses consistent styling with the rest of the app
- [✅] Navigation back to other pages works correctly
- [✅] Page is responsive on mobile devices

---

### 3. Footer

**Weight:** 4%

#### Description

A footer component that appears at the bottom of pages, containing dummy links, copyright information, and additional navigation options. The footer should be consistent across all pages.

#### User Stories

- As a user, I want to see footer information on each page so that I can access additional links and information.
- As a user, I want the footer to include common links like Privacy, Terms, and Contact so that I can find important information easily.
- As a developer, I want a reusable footer component so that I can maintain consistency across pages.

#### Acceptance Criteria

- [✅] Footer component is created and reusable
- [✅] Footer includes copyright notice (© 2025 UPSU Union Shop)
- [✅] Footer includes at least 3 dummy links (Privacy, Terms, Contact)
- [✅] Footer displays "This is a coursework project, not the real shop" message
- [✅ ] Footer is present on at least one page (can be extended to all pages)
- [✅] Footer styling is consistent with app theme

---

### 4. Dummy Collections Page

**Weight:** 5%

#### Description

A page displaying various product collections using hardcoded data. The page should showcase different categories of products available in the shop.

#### User Stories

- As a customer, I want to browse different product collections so that I can find items by category.
- As a customer, I want to see collection names and representative images so that I can quickly identify what each collection contains.
- As a shopper, I want to click on a collection to view products within that collection.

#### Acceptance Criteria

- [✅] Collections page displays at least 3-4 different collections
- [✅] Each collection shows a title and placeholder image
- [✅] Page is accessible via navigation bar
- [✅] Layout is responsive and mobile-friendly
- [✅] Hardcoded data is acceptable for this feature
- [✅] Page loads without errors

---

### 5. Dummy Collection Page

**Weight:** 5%

#### Description

A page showing products within a specific collection, including product listings with basic filtering and sorting capabilities. The page should display product cards with images, names, and prices.

#### User Stories

- As a customer, I want to view all products in a collection so that I can see what's available in that category.
- As a shopper, I want to see product images and prices so that I can make purchasing decisions.
- As a user, I want basic filters to work so that I can narrow down products by criteria.

#### Acceptance Criteria

- [✅] Collection page displays products in a grid or list layout
- [✅] Each product shows image, name, and price
- [✅] Page includes dropdown/filter widgets (functionality not required yet)
- [✅] Hardcoded data is acceptable
- [✅] Page is responsive on mobile devices
- [✅] Navigation to individual product pages works (if implemented)

---

### 6. Dummy Product Page

**Weight:** 4%

#### Description

A detailed product page showing product information, images, descriptions, and action buttons. The page should display all relevant product details in an organized manner.

#### User Stories

- As a customer, I want to view detailed product information so that I can learn more before purchasing.
- As a shopper, I want to see multiple product images so that I can examine the product closely.
- As a user, I want to see an "Add to Cart" button so that I can indicate my intent to purchase.

#### Acceptance Criteria

- [✅] Product page displays product name, price, and description
- [✅] Page includes product image(s)
- [✅] Dropdown menus for size/color/options are present (don't need to function yet)
- [✅] "Add to Cart" button is visible (doesn't need to work yet)
- [✅] Hardcoded data is acceptable
- [✅] Page is accessible via navigation or collection page
- [✅] Layout is responsive and mobile-friendly

---

### 7. Sale Collection

**Weight:** 4%

#### Description

A dedicated page displaying products on sale with discounted prices and promotional messaging. The page should highlight special offers and deals.

#### User Stories

- As a customer, I want to see sale items so that I can find discounted products.
- As a bargain hunter, I want to see original and sale prices so that I can see how much I'm saving.
- As a shopper, I want promotional messaging so that I'm aware of current deals.

#### Acceptance Criteria

- [✅] Sale page displays products with discounted prices
- [✅] Each product shows both original and sale price
- [✅] Page includes promotional messaging
- [✅] Hardcoded data is acceptable
- [✅] Page is accessible via navigation bar
- [✅] Layout is consistent with other collection pages
- [✅] Page is responsive on mobile devices

---

### 8. Authentication UI

**Weight:** 3%

#### Description

Login and signup pages with relevant form fields and widgets. The forms don't need to function yet but should have proper UI elements.

#### User Stories

- As a new user, I want to see a signup form so that I can create an account.
- As a returning user, I want to see a login form so that I can access my account.
- As a user, I want clear form fields so that I know what information to provide.

#### Acceptance Criteria

- [✅] Login page includes email and password fields
- [✅] Signup page includes name, email, and password fields
- [✅] Forms include submit buttons
- [✅] Forms have basic validation styling (UI only)
- [✅] Widgets are present but don't need to function yet
- [✅] Pages are accessible via navigation or Account button
- [✅] Layout is responsive on mobile devices

---

### 9. Static Navbar

**Weight:** 5%

#### Description

A top navigation bar for desktop view with links to main sections. The navbar should collapse to a menu button on mobile devices.

#### User Stories

- As a user, I want a navigation bar at the top so that I can access different sections easily.
- As a mobile user, I want the navbar to collapse to a menu button so that it doesn't take up too much screen space.
- As a user, I want clear navigation links so that I can find what I'm looking for quickly.

#### Acceptance Criteria

- [✅] Navbar displays "UPSU Union Shop" branding
- [✅] Navbar includes links to Home, Collections, Sale, About Us, Account, and Cart
- [✅] Navbar is visible on all pages
- [✅] Links navigate to appropriate pages (or show "coming soon" messages)
- [✅] On mobile, navbar should collapse to a menu button
- [✅] Navbar styling is consistent with app theme

---

## Intermediate Features (36%)

### 10. Dynamic Collections Page

**Weight:** 6%

#### Description

An enhanced collections page that loads data from Firebase or a data model, with functional sorting, filtering, and pagination widgets.

#### User Stories

- As a customer, I want collections to load from a database so that I see current product categories.
- As a user, I want to sort collections so that I can organize them by preference.
- As a shopper, I want filtering options so that I can find specific types of collections.

#### Acceptance Criteria

- [✅] Collections are loaded from Firebase or data models
- [✅] Sorting functionality works (e.g., by name, date added)
- [✅] Filtering functionality works (e.g., by category type)
- [✅] Pagination widgets are functional
- [✅] Page updates dynamically when filters/sorting change
- [✅] Loading states are displayed while fetching data
- [✅] Error handling is implemented for failed data fetches

---

### 11. Dynamic Collection Page

**Weight:** 6%

#### Description

An enhanced collection page that loads products from a database with functional sorting, filtering, and pagination.

#### User Stories

- As a customer, I want to see real product data so that I know what's actually available.
- As a shopper, I want to filter products by price, size, or color so that I can find what I need.
- As a user, I want to sort products by price or popularity so that I can browse efficiently.

#### Acceptance Criteria

- [✅] Products are loaded from Firebase or data models
- [✅] Sorting functionality works (e.g., by price, name, popularity)
- [✅] Filtering functionality works (e.g., by price range, size, color)
- [✅] Pagination works correctly
- [✅] Page updates dynamically based on user selections
- [✅] Loading states are displayed
- [✅] Error handling is implemented

---

### 12. Functional Product Pages

**Weight:** 6%

#### Description

Enhanced product pages with working dropdowns for options, counters for quantity, and functional "Add to Cart" buttons.

#### User Stories

- As a customer, I want to select product options so that I can customize my purchase.
- As a shopper, I want to choose quantity so that I can buy multiple items.
- As a user, I want the "Add to Cart" button to work so that I can save items for purchase.

#### Acceptance Criteria

- [✅] Products are loaded from Firebase or data models
- [✅] Dropdown menus work for selecting options (size, color, etc.)
- [✅] Quantity counter buttons work correctly
- [✅] "Add to Cart" button adds items to cart with selected options
- [✅] Confirmation message is shown when item is added
- [✅] Product data persists in cart
- [✅] Error handling for out-of-stock or invalid selections

---

### 13. Shopping Cart

**Weight:** 6%

#### Description

A functional shopping cart where users can add items, view their cart, and use checkout buttons. The cart should persist data and allow basic cart management.

#### User Stories

- As a shopper, I want to add items to my cart so that I can purchase multiple products.
- As a customer, I want to view my cart so that I can see what I'm about to buy.
- As a user, I want to remove items from my cart so that I can change my mind.
- As a shopper, I want to see the total price so that I know how much I'll spend.

#### Acceptance Criteria

- [ ] Users can add items to cart from product pages
- [ ] Cart page displays all added items with images, names, and prices
- [ ] Users can edit quantities in the cart
- [ ] Users can remove items from the cart
- [ ] Cart displays subtotal, tax (if applicable), and total
- [ ] Cart data persists during the session
- [ ] Checkout button is present (doesn't need to process payment yet)
- [ ] Empty cart state is handled gracefully

---

### 14. Print Shack (Personalization Page)

**Weight:** 3%

#### Description

A text personalization page with an associated About page. The form should dynamically update based on selected fields.

#### User Stories

- As a customer, I want to personalize products with text so that I can create custom items.
- As a user, I want to see a preview of my personalization so that I know what it will look like.
- As a customer, I want to read about the personalization service so that I understand the options.

#### Acceptance Criteria

- [ ] Personalization form includes text input fields
- [ ] Form dynamically updates preview based on user input
- [ ] About page explains personalization service
- [ ] Form validates input (e.g., character limits)
- [ ] Users can add personalized items to cart
- [ ] Personalization options are saved with cart items

---

### 15. Navigation

**Weight:** 3%

#### Description

Full navigation system across all pages using buttons, navbar, and URLs. Users should be able to navigate seamlessly throughout the app.

#### User Stories

- As a user, I want to navigate between pages using buttons so that I can explore the app easily.
- As a customer, I want to use the navbar to access main sections so that I can find what I need quickly.
- As a user, I want URL-based navigation so that I can bookmark or share specific pages.

#### Acceptance Criteria

- [ ] All pages are accessible via navbar links
- [ ] Back buttons work on all relevant pages
- [ ] Product and collection links navigate correctly
- [ ] URL routes are properly configured
- [ ] Navigation state is maintained appropriately
- [ ] Deep linking works for specific products/collections

---

### 16. Responsiveness

**Weight:** 5%

#### Description

The app layout should be adaptive and responsive, functioning well on desktop and mobile devices without the need for physical device testing.

#### User Stories

- As a mobile user, I want the app to display correctly on my phone so that I can shop on the go.
- As a desktop user, I want to take advantage of larger screens so that I can see more content at once.
- As a user, I want the interface to adapt smoothly when I resize my browser window.

#### Acceptance Criteria

- [ ] All pages render correctly on mobile screen sizes (360px - 480px width)
- [ ] All pages render correctly on tablet screen sizes (768px - 1024px width)
- [ ] All pages render correctly on desktop screen sizes (1200px+ width)
- [ ] Images scale appropriately across devices
- [ ] Text remains readable on all screen sizes
- [ ] Navigation adapts to mobile (hamburger menu) and desktop (full navbar)
- [ ] Buttons and interactive elements are appropriately sized for touch on mobile
- [ ] No horizontal scrolling occurs on any device size

---

## Advanced Features (25%)

### 17. Authentication System

**Weight:** 8%

#### Description

Full user authentication and account management system using Firebase Authentication or similar service. Includes login, signup, password reset, and account dashboard.

#### User Stories

- As a new user, I want to create an account so that I can save my information.
- As a returning user, I want to log in so that I can access my saved data.
- As a user, I want to reset my password if I forget it so that I can regain access.
- As a logged-in user, I want to view and edit my account details so that I can keep my information current.

#### Acceptance Criteria

- [ ] Users can sign up with email and password
- [ ] Users can log in with valid credentials
- [ ] Users can log out successfully
- [ ] Password reset functionality works via email
- [ ] Account dashboard shows user information
- [ ] Users can edit their profile information
- [ ] Authentication state persists across sessions
- [ ] Error messages are clear and helpful
- [ ] Integration with Google/Facebook login (optional but recommended)

---

### 18. Cart Management

**Weight:** 6%

#### Description

Enhanced cart functionality including quantity editing, item removal, price calculations, and cart persistence using local storage or Firebase.

#### User Stories

- As a shopper, I want my cart to save between sessions so that I don't lose my items.
- As a customer, I want to easily edit quantities so that I can adjust my order.
- As a user, I want accurate price calculations so that I know the exact cost.
- As a shopper, I want to see shipping costs so that I can budget appropriately.

#### Acceptance Criteria

- [ ] Cart persists data using local storage or Firebase
- [ ] Users can increment/decrement item quantities
- [ ] Users can remove individual items
- [ ] Users can clear entire cart
- [ ] Price calculations are accurate (subtotal, tax, shipping, total)
- [ ] Cart updates in real-time as changes are made
- [ ] Cart displays item count badge in navbar
- [ ] Empty cart message is displayed when cart is empty
- [ ] Cart syncs across devices for logged-in users

---

### 19. Search System

**Weight:** 4%

#### Description

Complete search functionality with search buttons throughout the app and a dedicated search results page with filtering options.

#### User Stories

- As a customer, I want to search for products by name so that I can find specific items quickly.
- As a user, I want search suggestions as I type so that I can find products faster.
- As a shopper, I want to filter search results so that I can narrow down options.

#### Acceptance Criteria

- [ ] Search bar is accessible from navbar on all pages
- [ ] Search functionality queries product database
- [ ] Search results page displays matching products
- [ ] Search supports partial matching
- [ ] Search results can be filtered and sorted
- [ ] Search history is saved (optional)
- [ ] No results state is handled gracefully
- [ ] Search performance is optimized for large datasets

---

## General Requirements

### Git

**Weight:** 8%

#### Description

Regular, meaningful commits throughout development with clear commit messages.

#### Acceptance Criteria

- [ ] Repository has at least 20+ commits
- [ ] Commits are made regularly throughout development period
- [ ] Commit messages are clear and descriptive
- [ ] Commits are small and focused on specific changes
- [ ] No large files committed unnecessarily
- [ ] .gitignore is properly configured

---

### README

**Weight:** 5%

#### Description

Comprehensive, well-formatted README file that documents the project.

#### Acceptance Criteria

- [ ] README includes project title and description
- [ ] Setup instructions are clear and complete
- [ ] Features list is comprehensive
- [ ] Technologies used are documented
- [ ] Screenshots/GIFs are included
- [ ] Known issues are documented
- [ ] Future improvements are listed
- [ ] Markdown formatting is proper

---

### Testing

**Weight:** 6%

#### Description

Comprehensive tests covering all or most of the application functionality.

#### Acceptance Criteria

- [ ] Unit tests for business logic
- [ ] Widget tests for UI components
- [ ] Integration tests for key user flows
- [ ] All tests pass successfully
- [ ] Test coverage is >70%
- [ ] Tests are well-organized and documented

---

### External Services

**Weight:** 6%

#### Description

Integration with Firebase or other cloud services for data storage, authentication, and other features.

#### Acceptance Criteria

- [ ] Firebase project is properly configured
- [ ] Firestore/Realtime Database stores product data
- [ ] Firebase Authentication is integrated (if implementing auth)
- [ ] Firebase Storage for images (optional)
- [ ] API keys and secrets are properly secured
- [ ] Error handling for service failures

---

**Total: 100%**

This requirements document provides a clear roadmap for building your Union Shop app according to the marking criteria. Each feature includes user stories and acceptance criteria that align with the assessment requirements.
