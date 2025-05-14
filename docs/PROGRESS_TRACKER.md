# Progress Tracker
# Fruits Hub Implementation & Testing

**Version:** 1.0
**Date:** 2025-11-01
**Last Updated:** 2025-11-01 (Session Start)

---

## Quick Stats

| Metric | Value |
|--------|-------|
| **Total Features** | 20 |
| **Completed Features** | 0 |
| **In Progress** | 0 |
| **Not Started** | 20 |
| **Critical Bugs Fixed** | 1 (Platform._operatingSystem) |
| **Tests Passed** | 0 / 128 |
| **Overall Progress** | 5% |

---

## Implementation Status by Phase

### Phase 1: Critical Foundation (P0) - 0% Complete
- [ ] Persistent Shopping Cart
- [ ] Advanced Search & Filters
- [ ] Product Reviews & Ratings
- [ ] Multiple Delivery Addresses
- [ ] Multiple Payment Methods

### Phase 2: Customer Retention (P1) - 0% Complete
- [ ] Push Notifications
- [ ] Promo Codes & Discounts
- [ ] Loyalty Points Program
- [ ] Wishlist / Favorites
- [ ] Referral Program

### Phase 3: Premium Features (P1) - 0% Complete
- [ ] Premium Subscription
- [ ] Subscription Boxes

### Phase 4: Enhanced Shopping (P1-P2) - 0% Complete
- [ ] Real-Time Order Tracking
- [ ] Quick Reorder
- [ ] Personalized Recommendations

### Phase 5: Financial Features (P1-P2) - 0% Complete
- [ ] In-App Wallet
- [ ] Export Invoices / Reports

### Phase 6: Support Features (P1) - 0% Complete
- [ ] Live Chat Support
- [ ] Order Issues / Returns

### Phase 7: Content Features (P3) - 0% Complete
- [ ] Recipe Suggestions

### Phase 8: Admin Dashboard (P0) - 0% Complete
- [ ] Comprehensive Admin Panel

---

## Session Goals & Priorities

### Documentation Phase ✅ IN PROGRESS
- [x] Create PRD Document
- [x] Create GAP Analysis
- [x] Create Progress Tracker (this document)
- [ ] Create Detailed Test Scenarios Document

### Assessment Phase ⏳ NEXT
- [ ] Start Flutter app on Chrome (port 8080 or 8888 or 9000)
- [ ] Connect Chrome MCP tools
- [ ] Navigate through all screens
- [ ] Document current state (what works, what doesn't)
- [ ] Identify critical blocking bugs

### Bug Fix Phase ⏳ PENDING
- [ ] Fix authentication flow issues (if any)
- [ ] Fix product loading issues (if any)
- [ ] Fix cart functionality issues (if any)
- [ ] Fix checkout flow issues (if any)
- [ ] Ensure end-to-end order can be placed successfully

### Implementation Phase (P0 Features) ⏳ PENDING
- [ ] Feature 1: Persistent Shopping Cart
- [ ] Feature 2: Advanced Search & Filters
- [ ] Feature 3: Product Reviews & Ratings

### Testing Phase ⏳ PENDING
- [ ] Execute 100+ test scenarios
- [ ] Track results in this document
- [ ] Fix bugs found during testing
- [ ] Re-test until all pass

### Finalization Phase ⏳ PENDING
- [ ] Update all documentation
- [ ] Document roadmap items (incomplete features)
- [ ] Commit and push all changes
- [ ] Update TEST_CASES.md with final results

---

## Detailed Task Breakdown

### PHASE 0: Current State Assessment

#### Task 0.1: Start Application & Connect Tools
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** 15 minutes

**Subtasks:**
- [ ] Check which Flutter process is running successfully (port 8080, 8888, or 9000)
- [ ] Verify Chrome browser is connected
- [ ] Use Chrome MCP to list pages
- [ ] Take initial screenshot of app state
- [ ] Document current URL and app state

**Acceptance Criteria:**
- ✅ App loads without errors
- ✅ Chrome MCP connected and functional
- ✅ Can take snapshots and screenshots
- ✅ Initial state documented

---

#### Task 0.2: Test Authentication Flow
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** 30 minutes

**Subtasks:**
- [ ] Navigate to login screen
- [ ] Test email/password login with invalid credentials (should show error)
- [ ] Test email/password login with valid credentials (if account exists)
- [ ] Navigate to signup screen
- [ ] Test signup form validation (empty fields, invalid email, weak password)
- [ ] Test signup with valid data
- [ ] Test Google Sign-In button
- [ ] Verify redirect to home screen after successful login
- [ ] Test logout functionality
- [ ] Verify session persistence (reload page, should stay logged in)

**Bugs Found:**
- [ ] Document any authentication bugs here

**Acceptance Criteria:**
- ✅ Can create new account successfully
- ✅ Can login with credentials
- ✅ Google Sign-In works (if Firebase configured)
- ✅ Session persists across reloads
- ✅ Can logout successfully

---

#### Task 0.3: Test Product Browsing
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** 20 minutes

**Subtasks:**
- [ ] Navigate to home/product list screen
- [ ] Verify products load from Firestore
- [ ] Count how many products display
- [ ] Check product images load correctly
- [ ] Verify product names, prices display
- [ ] Tap on a product to view details
- [ ] Verify product detail page shows all information
- [ ] Check if reviews display (if any exist)
- [ ] Navigate back to product list

**Bugs Found:**
- [ ] Document any product loading bugs here

**Acceptance Criteria:**
- ✅ Products load successfully from Firestore
- ✅ At least 5 products visible
- ✅ Product images load without errors
- ✅ Product detail page accessible
- ✅ All product information displays correctly

---

#### Task 0.4: Test Shopping Cart
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** 30 minutes

**Subtasks:**
- [ ] Add a product to cart from product list
- [ ] Verify cart icon shows item count (1)
- [ ] Navigate to cart screen
- [ ] Verify product appears in cart with correct quantity
- [ ] Test quantity increment (+ button)
- [ ] Test quantity decrement (- button)
- [ ] Verify total price updates correctly
- [ ] Test remove item from cart
- [ ] Add multiple different products to cart
- [ ] Verify cart total calculates correctly
- [ ] Reload page and check if cart persists (EXPECTED TO FAIL - not implemented yet)

**Bugs Found:**
- [ ] Document any cart bugs here

**Known Issues:**
- ❌ Cart does not persist (session only) - planned for implementation

**Acceptance Criteria:**
- ✅ Can add products to cart
- ✅ Cart count badge updates
- ✅ Quantity adjustment works
- ✅ Remove from cart works
- ✅ Total price calculates correctly
- ⏳ Cart persists across sessions (not implemented yet)

---

#### Task 0.5: Test Checkout Flow
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** 45 minutes

**Subtasks:**
- [ ] Add products to cart (if not already done)
- [ ] Navigate to checkout
- [ ] **Step 1: Delivery Address**
  - [ ] Fill in all required address fields
  - [ ] Test validation (empty fields should show errors)
  - [ ] Proceed to next step
- [ ] **Step 2: Shipping Method**
  - [ ] Select a shipping option
  - [ ] Verify shipping cost displays
  - [ ] Proceed to next step
- [ ] **Step 3: Payment Method**
  - [ ] Select a payment method (COD, Card, etc.)
  - [ ] Verify order summary shows all items
  - [ ] Verify subtotal, shipping, tax, total
  - [ ] Proceed to confirmation
- [ ] **Step 4: Confirmation**
  - [ ] Review order details
  - [ ] Place order
  - [ ] Verify success message
  - [ ] Check if redirected to orders or home
  - [ ] Verify cart is cleared after order

**Bugs Found:**
- [ ] Document any checkout bugs here

**Acceptance Criteria:**
- ✅ All checkout steps accessible
- ✅ Address validation works
- ✅ Shipping method selection works
- ✅ Payment method selection works
- ✅ Order summary displays correctly
- ✅ Order placement succeeds
- ✅ Cart clears after successful order

---

#### Task 0.6: Test Order History
**Status:** ⏳ Not Started
**Priority:** High
**Estimated Time:** 20 minutes

**Subtasks:**
- [ ] Navigate to profile/orders section
- [ ] Verify recently placed order appears
- [ ] Tap on order to view details
- [ ] Verify all order details match (items, quantities, total, address)
- [ ] Check order status displays correctly
- [ ] Test order cancellation (if within 30 min window)
- [ ] Verify cancellation succeeds or shows error if outside window

**Bugs Found:**
- [ ] Document any order history bugs here

**Acceptance Criteria:**
- ✅ Orders list loads successfully
- ✅ Order details accessible
- ✅ Order information accurate
- ✅ Cancellation works within time window
- ✅ Cancellation blocked after 30 minutes

---

### PHASE 1: Critical Bug Fixes

#### Bug Fix 1.1: Authentication Issues
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** Varies based on bugs found

**Potential Issues:**
- [ ] Firebase Auth not configured correctly
- [ ] Email validation issues
- [ ] Password validation issues
- [ ] Google Sign-In not working
- [ ] Session not persisting
- [ ] Logout not clearing session

**Fix Process:**
- [ ] Identify specific bug from testing
- [ ] Read relevant code files
- [ ] Implement fix
- [ ] Test fix
- [ ] Commit changes

---

#### Bug Fix 1.2: Product Loading Issues
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** Varies based on bugs found

**Potential Issues:**
- [ ] Firestore query errors
- [ ] Products collection empty
- [ ] Image loading failures
- [ ] Data mapping errors
- [ ] State management issues in ProductsCubit

**Fix Process:**
- [ ] Identify specific bug from testing
- [ ] Check Firestore data exists
- [ ] Review repository and cubit code
- [ ] Implement fix
- [ ] Test fix
- [ ] Commit changes

---

#### Bug Fix 1.3: Cart Functionality Issues
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** Varies based on bugs found

**Potential Issues:**
- [ ] Add to cart not working
- [ ] Quantity update failing
- [ ] Remove from cart not working
- [ ] Total calculation incorrect
- [ ] Cart state not updating UI

**Fix Process:**
- [ ] Identify specific bug from testing
- [ ] Review CartCubit code
- [ ] Implement fix
- [ ] Test fix
- [ ] Commit changes

---

#### Bug Fix 1.4: Checkout Flow Issues
**Status:** ⏳ Not Started
**Priority:** Critical
**Estimated Time:** Varies based on bugs found

**Potential Issues:**
- [ ] Address validation failing
- [ ] Shipping method not selectable
- [ ] Payment method not selectable
- [ ] Order creation failing
- [ ] Cart not clearing after order
- [ ] Firebase write errors

**Fix Process:**
- [ ] Identify specific bug from testing
- [ ] Review checkout cubits and services
- [ ] Check Firestore security rules
- [ ] Implement fix
- [ ] Test fix
- [ ] Commit changes

---

### PHASE 2: Feature Implementation - Persistent Cart

#### Feature 1.1: Create Cart Service & Repository
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 2 hours

**Subtasks:**
- [ ] Create `lib/core/services/cart_service.dart`
- [ ] Create `lib/core/repos/cart_repo.dart` abstract interface
- [ ] Implement CartRepoImpl with Firestore operations
- [ ] Define Firestore schema: `carts/{userId}/items/{productId}`
- [ ] Implement CRUD operations:
  - [ ] addToCart(userId, productId, quantity)
  - [ ] updateCartItem(userId, productId, quantity)
  - [ ] removeFromCart(userId, productId)
  - [ ] getCart(userId)
  - [ ] clearCart(userId)
- [ ] Register dependencies in get_it_service.dart

**Files to Create:**
- `lib/core/services/cart_service.dart`
- `lib/core/repos/cart_repo.dart`
- `lib/core/repos/cart_repo_impl.dart`

**Acceptance Criteria:**
- ✅ Cart service can write to Firestore
- ✅ Cart service can read from Firestore
- ✅ All CRUD operations tested and working

---

#### Feature 1.2: Update CartCubit with Persistence
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 3 hours

**Subtasks:**
- [ ] Modify CartCubit to use CartService
- [ ] Implement real-time cart sync:
  - [ ] On addToCart → save to Firestore
  - [ ] On updateQuantity → update in Firestore
  - [ ] On removeFromCart → delete from Firestore
- [ ] Implement loadCart() method to fetch cart on app start
- [ ] Implement merge logic for local + cloud cart
- [ ] Handle offline scenarios (queue changes, sync when online)
- [ ] Add loading states for cart operations
- [ ] Handle errors gracefully

**Files to Modify:**
- `lib/features/home/presentation/cubits/cart_cubit.dart`

**Acceptance Criteria:**
- ✅ Cart saves to Firestore on every change
- ✅ Cart loads from Firestore on app start
- ✅ Cart syncs across devices (test with multiple browsers)
- ✅ Offline changes sync when connection restored
- ✅ Merge logic combines local + cloud cart correctly

---

#### Feature 1.3: Test Persistent Cart
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 1 hour

**Test Scenarios:**
- [ ] Add item to cart, reload page → item persists
- [ ] Add item, logout, login → cart syncs
- [ ] Add items on device 1, login on device 2 → cart syncs
- [ ] Add item offline, go online → syncs to Firestore
- [ ] Merge scenario: local cart (A,B) + cloud cart (B,C) → merged (A,B,C)
- [ ] Out-of-stock item in cart → shows warning
- [ ] Delete item from cart → removes from Firestore

**Acceptance Criteria:**
- ✅ All 7 test scenarios pass
- ✅ Cart persists reliably across sessions
- ✅ No data loss or duplication

---

### PHASE 3: Feature Implementation - Search & Filters

#### Feature 2.1: Create Search UI Components
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 2 hours

**Subtasks:**
- [ ] Create `lib/features/home/presentation/widgets/search_bar_widget.dart`
- [ ] Implement search input with magnifying glass icon
- [ ] Add clear (X) button when text entered
- [ ] Implement debouncing (300ms delay before search)
- [ ] Create `lib/features/home/presentation/widgets/filter_drawer.dart`
- [ ] Build filter UI:
  - [ ] Price range slider (min/max)
  - [ ] Category multi-select checkboxes
  - [ ] Rating filter (1★+, 2★+, 3★+, 4★+, 5★)
  - [ ] Availability toggles (In Stock, On Sale, Best Sellers)
  - [ ] Sort dropdown (Price Low-High, High-Low, Rating, Newest, Popular)
- [ ] Add "Apply Filters" and "Reset" buttons
- [ ] Display active filter chips below search bar

**Files to Create:**
- `lib/features/home/presentation/widgets/search_bar_widget.dart`
- `lib/features/home/presentation/widgets/filter_drawer.dart`
- `lib/features/home/presentation/widgets/active_filter_chips.dart`

**Acceptance Criteria:**
- ✅ Search bar displays prominently at top
- ✅ Debouncing prevents excessive queries
- ✅ Filter drawer accessible from icon button
- ✅ All filter options functional
- ✅ Active filters display as chips

---

#### Feature 2.2: Implement Search Logic & Firestore Indexes
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 3 hours

**Subtasks:**
- [ ] Create `lib/features/home/presentation/cubits/search_cubit.dart`
- [ ] Implement search query across fields:
  - [ ] Product name
  - [ ] Product description
  - [ ] Category
  - [ ] Tags (if exists)
- [ ] Implement filter logic (price range, category, rating, availability)
- [ ] Implement sort logic (price, rating, date, popularity)
- [ ] Combine filters with AND logic (all must match)
- [ ] Create Firestore composite indexes:
  - [ ] category + price
  - [ ] category + avgRating
  - [ ] isAvailable + price
  - [ ] etc. (deploy will auto-suggest indexes)
- [ ] Store search history locally (SharedPreferences, last 10 searches)
- [ ] Implement "no results" state with suggested products

**Files to Create:**
- `lib/features/home/presentation/cubits/search_cubit.dart`
- `lib/core/services/search_service.dart`

**Files to Modify:**
- `firestore.indexes.json` (create if doesn't exist)

**Acceptance Criteria:**
- ✅ Search returns results within 500ms
- ✅ Filters combine correctly (AND logic)
- ✅ Sort options work as expected
- ✅ Firestore indexes prevent errors
- ✅ Search history saves and displays

---

#### Feature 2.3: Integrate Search into Product List
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 2 hours

**Subtasks:**
- [ ] Modify `lib/features/home/presentation/views/home_view.dart`
- [ ] Add SearchBarWidget at top of product list
- [ ] Add filter icon button to open FilterDrawer
- [ ] Connect SearchCubit to product list
- [ ] Display filtered/sorted products
- [ ] Show loading indicator during search
- [ ] Display result count ("Showing 24 of 150 products")
- [ ] Handle empty results state
- [ ] Add "Clear Search" button when searching

**Files to Modify:**
- `lib/features/home/presentation/views/home_view.dart`

**Acceptance Criteria:**
- ✅ Search integrates seamlessly with product list
- ✅ Loading states display correctly
- ✅ Results update in real-time as filters change
- ✅ Clear search returns to full product list

---

#### Feature 2.4: Test Search & Filters
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 1 hour

**Test Scenarios:**
- [ ] Search for product name → correct results
- [ ] Search for category → all products in category
- [ ] Filter by price range $10-$20 → only products in range
- [ ] Filter by category "Vegetables" → only vegetables
- [ ] Filter by 4★+ rating → only highly rated products
- [ ] Combine search + filters → correct results
- [ ] Sort by price low-to-high → ascending order
- [ ] Sort by rating → highest rated first
- [ ] Clear filters → returns to full list
- [ ] Search with no results → shows "no results" message
- [ ] Search history displays last 10 searches

**Acceptance Criteria:**
- ✅ All 11 test scenarios pass
- ✅ Search and filters work accurately
- ✅ Performance meets 500ms target

---

### PHASE 4: Feature Implementation - Product Reviews

#### Feature 3.1: Create Review Display UI
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 2 hours

**Subtasks:**
- [ ] Create `lib/features/home/presentation/widgets/review_list_widget.dart`
- [ ] Display review list on product detail page
- [ ] Show review count and average rating at top
- [ ] Display individual reviews:
  - [ ] User name and photo
  - [ ] Star rating (visual stars)
  - [ ] Review comment
  - [ ] Review images (if any)
  - [ ] Review date
  - [ ] Helpful count and button
  - [ ] Report button
- [ ] Implement pagination (load more reviews)
- [ ] Add filter tabs (All, 5★, 4★, 3★, 2★, 1★)
- [ ] Sort reviews (Newest first, Highest rated, Most helpful)

**Files to Create:**
- `lib/features/home/presentation/widgets/review_list_widget.dart`
- `lib/features/home/presentation/widgets/review_item_widget.dart`

**Acceptance Criteria:**
- ✅ Reviews display correctly on product page
- ✅ All review information shows (user, rating, comment, images)
- ✅ Pagination loads more reviews
- ✅ Filter and sort options work

---

#### Feature 3.2: Create Review Submission UI
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 2 hours

**Subtasks:**
- [ ] Create `lib/features/home/presentation/widgets/submit_review_dialog.dart`
- [ ] Build review form:
  - [ ] Star rating selector (tap to select 1-5 stars)
  - [ ] Comment text field (50-500 characters)
  - [ ] Character counter
  - [ ] Image picker (up to 3 photos)
  - [ ] Image preview with remove option
  - [ ] Submit and Cancel buttons
- [ ] Validate form:
  - [ ] Rating required
  - [ ] Comment length validation
  - [ ] Image size limit (max 1MB each)
- [ ] Show review submission success/error messages

**Files to Create:**
- `lib/features/home/presentation/widgets/submit_review_dialog.dart`

**Acceptance Criteria:**
- ✅ Review form displays correctly
- ✅ All validations work
- ✅ Images can be selected and previewed
- ✅ Success/error feedback shown

---

#### Feature 3.3: Implement Review Service & Logic
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 3 hours

**Subtasks:**
- [ ] Create `lib/features/home/presentation/cubits/reviews_cubit.dart`
- [ ] Create `lib/core/repos/reviews_repo.dart`
- [ ] Implement review submission logic:
  - [ ] Validate user purchased product (check orders)
  - [ ] Upload review images to Firebase Storage
  - [ ] Create review document in `products/{productId}/reviews/{reviewId}`
  - [ ] Update product's avgRating and numOfReviews
- [ ] Implement review fetching logic (with filters, sort, pagination)
- [ ] Implement helpful vote logic (increment count)
- [ ] Implement report review logic (flag for admin)
- [ ] Prevent duplicate reviews (one per product per user)
- [ ] Allow edit existing review

**Files to Create:**
- `lib/features/home/presentation/cubits/reviews_cubit.dart`
- `lib/core/repos/reviews_repo.dart`
- `lib/core/services/reviews_service.dart`

**Acceptance Criteria:**
- ✅ Only verified purchasers can review
- ✅ Review submission saves to Firestore
- ✅ Images upload to Firebase Storage
- ✅ Product rating updates correctly
- ✅ Cannot submit duplicate reviews

---

#### Feature 3.4: Test Product Reviews
**Status:** ⏳ Not Started
**Priority:** P0
**Estimated Time:** 1 hour

**Test Scenarios:**
- [ ] User who purchased product can submit review
- [ ] User who didn't purchase cannot submit review
- [ ] Submit review with 5 stars and comment → success
- [ ] Submit review with images → images display
- [ ] Submit review with < 50 chars → validation error
- [ ] Submit review with > 500 chars → validation error
- [ ] Edit existing review → updates successfully
- [ ] Vote review as helpful → count increments
- [ ] Report inappropriate review → flags for admin
- [ ] Filter reviews by 5★ → only 5-star reviews show
- [ ] Product average rating updates after new review

**Acceptance Criteria:**
- ✅ All 11 test scenarios pass
- ✅ Review system works end-to-end
- ✅ Average rating calculates correctly

---

## Comprehensive Test Scenarios (100+)

### Authentication Tests (15 scenarios)

#### Test 1.1: Sign Up - Valid Data
**Status:** ⏳ Not Started
- Navigate to signup screen
- Enter valid email, password, name
- Submit form
- **Expected:** Account created, redirected to home
- **Actual:**

#### Test 1.2: Sign Up - Invalid Email
**Status:** ⏳ Not Started
- Navigate to signup screen
- Enter invalid email format (e.g., "notanemail")
- **Expected:** Validation error shown
- **Actual:**

#### Test 1.3: Sign Up - Weak Password
**Status:** ⏳ Not Started
- Navigate to signup screen
- Enter password < 6 characters
- **Expected:** Validation error shown
- **Actual:**

#### Test 1.4: Sign Up - Empty Fields
**Status:** ⏳ Not Started
- Navigate to signup screen
- Leave all fields empty, submit
- **Expected:** Validation errors for all required fields
- **Actual:**

#### Test 1.5: Sign Up - Duplicate Email
**Status:** ⏳ Not Started
- Sign up with email that already exists
- **Expected:** Error "Email already in use"
- **Actual:**

#### Test 1.6: Login - Valid Credentials
**Status:** ⏳ Not Started
- Navigate to login screen
- Enter correct email and password
- **Expected:** Logged in, redirected to home
- **Actual:**

#### Test 1.7: Login - Invalid Password
**Status:** ⏳ Not Started
- Navigate to login screen
- Enter correct email, wrong password
- **Expected:** Error "Invalid credentials"
- **Actual:**

#### Test 1.8: Login - Non-Existent Email
**Status:** ⏳ Not Started
- Enter email that doesn't exist
- **Expected:** Error "User not found"
- **Actual:**

#### Test 1.9: Login - Empty Fields
**Status:** ⏳ Not Started
- Leave email/password empty, submit
- **Expected:** Validation errors
- **Actual:**

#### Test 1.10: Google Sign-In Success
**Status:** ⏳ Not Started
- Click "Sign in with Google"
- Select Google account
- **Expected:** Logged in, profile created if first time
- **Actual:**

#### Test 1.11: Session Persistence
**Status:** ⏳ Not Started
- Log in, reload page
- **Expected:** User stays logged in
- **Actual:**

#### Test 1.12: Logout
**Status:** ⏳ Not Started
- Click logout button
- **Expected:** Logged out, redirected to login
- **Actual:**

#### Test 1.13: Protected Routes When Logged Out
**Status:** ⏳ Not Started
- Logout, try to access profile/cart/checkout
- **Expected:** Redirected to login
- **Actual:**

#### Test 1.14: Auto-Login on App Start
**Status:** ⏳ Not Started
- Log in, close app, reopen app
- **Expected:** Auto-logged in, on home screen
- **Actual:**

#### Test 1.15: Password Reset (if implemented)
**Status:** ⏳ Not Started
- Click "Forgot Password"
- Enter email, submit
- **Expected:** Reset email sent
- **Actual:**

---

### Product Browsing Tests (10 scenarios)

#### Test 2.1: Products Load on Home
**Status:** ⏳ Not Started
- Navigate to home screen
- **Expected:** At least 5 products displayed
- **Actual:**

#### Test 2.2: Product Images Load
**Status:** ⏳ Not Started
- Check all visible products
- **Expected:** All images load without errors
- **Actual:**

#### Test 2.3: Product Information Display
**Status:** ⏳ Not Started
- Check product cards
- **Expected:** Name, price, rating visible
- **Actual:**

#### Test 2.4: Product Detail Navigation
**Status:** ⏳ Not Started
- Tap on a product
- **Expected:** Navigate to product detail page
- **Actual:**

#### Test 2.5: Product Detail - Full Information
**Status:** ⏳ Not Started
- On product detail page
- **Expected:** Image, name, price, description, rating, reviews visible
- **Actual:**

#### Test 2.6: Product Detail - Add to Cart Button
**Status:** ⏳ Not Started
- On product detail page
- **Expected:** "Add to Cart" button visible and clickable
- **Actual:**

#### Test 2.7: Product List Scroll
**Status:** ⏳ Not Started
- Scroll through product list
- **Expected:** Smooth scrolling, lazy loading of more products
- **Actual:**

#### Test 2.8: Product Categories (if implemented)
**Status:** ⏳ Not Started
- Check if categories exist
- **Expected:** Can filter by category
- **Actual:**

#### Test 2.9: Best Sellers Section (if exists)
**Status:** ⏳ Not Started
- Check home screen
- **Expected:** "Best Sellers" section displays
- **Actual:**

#### Test 2.10: Product Out of Stock Display
**Status:** ⏳ Not Started
- Find out-of-stock product
- **Expected:** Shows "Out of Stock" label, cannot add to cart
- **Actual:**

---

### Shopping Cart Tests (20 scenarios)

#### Test 3.1: Add Product to Cart from List
**Status:** ⏳ Not Started
- Click "Add to Cart" on product card
- **Expected:** Product added, cart badge shows 1
- **Actual:**

#### Test 3.2: Add Product to Cart from Detail Page
**Status:** ⏳ Not Started
- On product detail, click "Add to Cart"
- **Expected:** Product added, confirmation shown
- **Actual:**

#### Test 3.3: Cart Badge Count
**Status:** ⏳ Not Started
- Add 3 different products
- **Expected:** Cart badge shows 3
- **Actual:**

#### Test 3.4: Navigate to Cart Screen
**Status:** ⏳ Not Started
- Click cart icon
- **Expected:** Navigate to cart screen
- **Actual:**

#### Test 3.5: Cart Items Display
**Status:** ⏳ Not Started
- On cart screen
- **Expected:** All added products visible with image, name, price, quantity
- **Actual:**

#### Test 3.6: Increment Quantity
**Status:** ⏳ Not Started
- Click + button on cart item
- **Expected:** Quantity increases, total updates
- **Actual:**

#### Test 3.7: Decrement Quantity
**Status:** ⏳ Not Started
- Click - button on cart item
- **Expected:** Quantity decreases, total updates
- **Actual:**

#### Test 3.8: Decrement to Zero Removes Item
**Status:** ⏳ Not Started
- Click - button until quantity is 0
- **Expected:** Item removed from cart
- **Actual:**

#### Test 3.9: Remove Item Button
**Status:** ⏳ Not Started
- Click remove/delete icon on cart item
- **Expected:** Item removed, cart updates
- **Actual:**

#### Test 3.10: Cart Total Calculation
**Status:** ⏳ Not Started
- Add items: $10, $15, $20
- **Expected:** Subtotal shows $45
- **Actual:**

#### Test 3.11: Empty Cart State
**Status:** ⏳ Not Started
- Remove all items from cart
- **Expected:** "Cart is empty" message shown
- **Actual:**

#### Test 3.12: Continue Shopping Button
**Status:** ⏳ Not Started
- On cart screen, click "Continue Shopping"
- **Expected:** Navigate back to product list
- **Actual:**

#### Test 3.13: Proceed to Checkout Button
**Status:** ⏳ Not Started
- On cart with items, click "Checkout"
- **Expected:** Navigate to checkout flow
- **Actual:**

#### Test 3.14: Add Same Product Twice
**Status:** ⏳ Not Started
- Add product A, then add product A again
- **Expected:** Quantity increments to 2, not duplicate entry
- **Actual:**

#### Test 3.15: Cart Persistence - Reload Page
**Status:** ⏳ Not Started (Will FAIL until implemented)
- Add items to cart, reload page
- **Expected:** Cart items persist
- **Actual:**

#### Test 3.16: Cart Persistence - Logout/Login
**Status:** ⏳ Not Started (Will FAIL until implemented)
- Add items, logout, login
- **Expected:** Cart items persist
- **Actual:**

#### Test 3.17: Cart Sync Across Devices
**Status:** ⏳ Not Started (Will FAIL until implemented)
- Add items on browser 1, login on browser 2
- **Expected:** Cart syncs to browser 2
- **Actual:**

#### Test 3.18: Out of Stock Item in Cart
**Status:** ⏳ Not Started
- Add item, admin marks it out of stock
- **Expected:** Warning badge on cart item
- **Actual:**

#### Test 3.19: Maximum Quantity Limit (if exists)
**Status:** ⏳ Not Started
- Try to add > max quantity (e.g., 99)
- **Expected:** Error or limit enforced
- **Actual:**

#### Test 3.20: Cart Total with Multiple Items
**Status:** ⏳ Not Started
- Add: 2x $10 item, 3x $5 item, 1x $20 item
- **Expected:** Subtotal = $55
- **Actual:**

---

### Checkout Flow Tests (25 scenarios)

#### Test 4.1: Checkout Button Enabled with Items
**Status:** ⏳ Not Started
- Cart has items
- **Expected:** "Checkout" button enabled
- **Actual:**

#### Test 4.2: Checkout Button Disabled Empty Cart
**Status:** ⏳ Not Started
- Cart is empty
- **Expected:** "Checkout" button disabled or hidden
- **Actual:**

#### Test 4.3: Navigate to Address Step
**Status:** ⏳ Not Started
- Click checkout
- **Expected:** Redirected to address form
- **Actual:**

#### Test 4.4: Address Form - All Fields Visible
**Status:** ⏳ Not Started
- On address step
- **Expected:** Name, phone, street, city, state, postal code fields visible
- **Actual:**

#### Test 4.5: Address Form - Empty Validation
**Status:** ⏳ Not Started
- Leave all fields empty, click "Next"
- **Expected:** Validation errors for all required fields
- **Actual:**

#### Test 4.6: Address Form - Invalid Phone
**Status:** ⏳ Not Started
- Enter invalid phone format
- **Expected:** Validation error shown
- **Actual:**

#### Test 4.7: Address Form - Invalid Postal Code
**Status:** ⏳ Not Started
- Enter invalid postal code
- **Expected:** Validation error shown
- **Actual:**

#### Test 4.8: Address Form - Valid Data Submit
**Status:** ⏳ Not Started
- Fill all fields correctly, click "Next"
- **Expected:** Proceed to shipping method step
- **Actual:**

#### Test 4.9: Shipping Method - Options Display
**Status:** ⏳ Not Started
- On shipping method step
- **Expected:** At least one shipping option visible
- **Actual:**

#### Test 4.10: Shipping Method - Selection
**Status:** ⏳ Not Started
- Select a shipping option
- **Expected:** Option selected, cost displayed
- **Actual:**

#### Test 4.11: Shipping Method - No Selection Error
**Status:** ⏳ Not Started
- Don't select option, click "Next"
- **Expected:** Error "Please select shipping method"
- **Actual:**

#### Test 4.12: Shipping Method - Proceed to Payment
**Status:** ⏳ Not Started
- Select shipping, click "Next"
- **Expected:** Navigate to payment method step
- **Actual:**

#### Test 4.13: Payment Method - Options Display
**Status:** ⏳ Not Started
- On payment method step
- **Expected:** Payment options visible (COD, Card, etc.)
- **Actual:**

#### Test 4.14: Payment Method - Selection
**Status:** ⏳ Not Started
- Select a payment method
- **Expected:** Option selected
- **Actual:**

#### Test 4.15: Payment Method - No Selection Error
**Status:** ⏳ Not Started
- Don't select option, click "Next"
- **Expected:** Error "Please select payment method"
- **Actual:**

#### Test 4.16: Order Summary Display
**Status:** ⏳ Not Started
- On payment/review step
- **Expected:** All cart items listed, quantities, prices shown
- **Actual:**

#### Test 4.17: Order Summary - Subtotal Correct
**Status:** ⏳ Not Started
- Check order summary
- **Expected:** Subtotal matches cart total
- **Actual:**

#### Test 4.18: Order Summary - Shipping Cost Displayed
**Status:** ⏳ Not Started
- Check order summary
- **Expected:** Shipping cost shown
- **Actual:**

#### Test 4.19: Order Summary - Tax Calculated (if applicable)
**Status:** ⏳ Not Started
- Check order summary
- **Expected:** Tax calculated and displayed
- **Actual:**

#### Test 4.20: Order Summary - Grand Total
**Status:** ⏳ Not Started
- Check order summary
- **Expected:** Grand total = subtotal + shipping + tax
- **Actual:**

#### Test 4.21: Place Order Button
**Status:** ⏳ Not Started
- Click "Place Order"
- **Expected:** Order submitted, loading indicator shown
- **Actual:**

#### Test 4.22: Order Placement Success
**Status:** ⏳ Not Started
- After placing order
- **Expected:** Success message, order ID shown
- **Actual:**

#### Test 4.23: Redirect After Order Success
**Status:** ⏳ Not Started
- After order success
- **Expected:** Redirected to order confirmation or home
- **Actual:**

#### Test 4.24: Cart Cleared After Order
**Status:** ⏳ Not Started
- Check cart after successful order
- **Expected:** Cart is empty
- **Actual:**

#### Test 4.25: Order Saved to Firestore
**Status:** ⏳ Not Started
- Check Firebase Console orders collection
- **Expected:** New order document created with correct data
- **Actual:**

---

### Order Management Tests (15 scenarios)

#### Test 5.1: Navigate to Orders Screen
**Status:** ⏳ Not Started
- Click on profile/orders section
- **Expected:** Navigate to orders list
- **Actual:**

#### Test 5.2: Orders List Display
**Status:** ⏳ Not Started
- On orders screen
- **Expected:** Recently placed order visible
- **Actual:**

#### Test 5.3: Order List - Order Information
**Status:** ⏳ Not Started
- Check order in list
- **Expected:** Order ID, date, total, status visible
- **Actual:**

#### Test 5.4: Order Detail Navigation
**Status:** ⏳ Not Started
- Tap on an order
- **Expected:** Navigate to order detail page
- **Actual:**

#### Test 5.5: Order Detail - All Information
**Status:** ⏳ Not Started
- On order detail page
- **Expected:** Items, quantities, prices, address, status visible
- **Actual:**

#### Test 5.6: Order Detail - Items Match
**Status:** ⏳ Not Started
- Check order items
- **Expected:** Items match what was ordered
- **Actual:**

#### Test 5.7: Order Detail - Total Matches
**Status:** ⏳ Not Started
- Check order total
- **Expected:** Total matches checkout amount
- **Actual:**

#### Test 5.8: Order Detail - Address Matches
**Status:** ⏳ Not Started
- Check delivery address
- **Expected:** Address matches what was entered
- **Actual:**

#### Test 5.9: Order Status - Pending
**Status:** ⏳ Not Started
- Check newly placed order
- **Expected:** Status shows "Pending" or "Confirmed"
- **Actual:**

#### Test 5.10: Cancel Order - Within Time Window
**Status:** ⏳ Not Started
- Place order, immediately try to cancel (< 30 min)
- **Expected:** Cancel succeeds, status updates to "Cancelled"
- **Actual:**

#### Test 5.11: Cancel Order - Outside Time Window
**Status:** ⏳ Not Started
- Try to cancel order > 30 minutes old
- **Expected:** Cancel blocked, error message shown
- **Actual:**

#### Test 5.12: Order History - Multiple Orders
**Status:** ⏳ Not Started
- Place multiple orders
- **Expected:** All orders appear in list
- **Actual:**

#### Test 5.13: Order History - Sort by Date
**Status:** ⏳ Not Started
- Check order list
- **Expected:** Orders sorted by date (newest first)
- **Actual:**

#### Test 5.14: Order History - Filter by Status (if implemented)
**Status:** ⏳ Not Started
- Apply status filter
- **Expected:** Only orders with selected status show
- **Actual:**

#### Test 5.15: Order Detail - Back Navigation
**Status:** ⏳ Not Started
- On order detail, click back
- **Expected:** Return to orders list
- **Actual:**

---

### Search & Filters Tests (15 scenarios - after implementation)

#### Test 6.1: Search Bar Visible
**Status:** ⏳ Not Started
- On product list
- **Expected:** Search bar at top of screen
- **Actual:**

#### Test 6.2: Search - Product Name
**Status:** ⏳ Not Started
- Search "Apple"
- **Expected:** All products with "Apple" in name show
- **Actual:**

#### Test 6.3: Search - Category
**Status:** ⏳ Not Started
- Search "Vegetables"
- **Expected:** All vegetable products show
- **Actual:**

#### Test 6.4: Search - No Results
**Status:** ⏳ Not Started
- Search "xyz123nonexistent"
- **Expected:** "No results" message, suggested products shown
- **Actual:**

#### Test 6.5: Search - Debouncing
**Status:** ⏳ Not Started
- Type quickly "Apple"
- **Expected:** Search waits 300ms before querying
- **Actual:**

#### Test 6.6: Search - Clear Button
**Status:** ⏳ Not Started
- Search something, click X button
- **Expected:** Search cleared, full product list shown
- **Actual:**

#### Test 6.7: Filter - Price Range
**Status:** ⏳ Not Started
- Set price range $10-$20
- **Expected:** Only products in range show
- **Actual:**

#### Test 6.8: Filter - Category Selection
**Status:** ⏳ Not Started
- Select "Fruits" category
- **Expected:** Only fruit products show
- **Actual:**

#### Test 6.9: Filter - Rating (4★+)
**Status:** ⏳ Not Started
- Select 4★+ filter
- **Expected:** Only products rated 4+ stars show
- **Actual:**

#### Test 6.10: Filter - In Stock Only
**Status:** ⏳ Not Started
- Toggle "In Stock" filter
- **Expected:** Out of stock products hidden
- **Actual:**

#### Test 6.11: Filter - Combine Multiple
**Status:** ⏳ Not Started
- Select price $5-$15 + category "Vegetables" + 4★+
- **Expected:** Only vegetables $5-$15 with 4+ stars show
- **Actual:**

#### Test 6.12: Filter - Reset Button
**Status:** ⏳ Not Started
- Apply filters, click "Reset"
- **Expected:** All filters cleared, full list shown
- **Actual:**

#### Test 6.13: Sort - Price Low to High
**Status:** ⏳ Not Started
- Select "Price: Low to High"
- **Expected:** Products sorted cheapest first
- **Actual:**

#### Test 6.14: Sort - Price High to Low
**Status:** ⏳ Not Started
- Select "Price: High to Low"
- **Expected:** Products sorted most expensive first
- **Actual:**

#### Test 6.15: Sort - Highest Rated
**Status:** ⏳ Not Started
- Select "Highest Rated"
- **Expected:** Products sorted by rating (5★ first)
- **Actual:**

---

### Review System Tests (13 scenarios - after implementation)

#### Test 7.1: View Reviews on Product Page
**Status:** ⏳ Not Started
- Navigate to product detail
- **Expected:** Reviews section visible
- **Actual:**

#### Test 7.2: Review Count Display
**Status:** ⏳ Not Started
- Check product with reviews
- **Expected:** Review count shown (e.g., "24 reviews")
- **Actual:**

#### Test 7.3: Average Rating Display
**Status:** ⏳ Not Started
- Check product
- **Expected:** Average rating shown (e.g., 4.5 stars)
- **Actual:**

#### Test 7.4: Submit Review - Not Purchased
**Status:** ⏳ Not Started
- Try to review product not purchased
- **Expected:** Error "Must purchase to review"
- **Actual:**

#### Test 7.5: Submit Review - Purchased
**Status:** ⏳ Not Started
- Purchase product, review it
- **Expected:** Can submit review successfully
- **Actual:**

#### Test 7.6: Submit Review - Form Validation
**Status:** ⏳ Not Started
- Leave fields empty, submit
- **Expected:** Validation errors shown
- **Actual:**

#### Test 7.7: Submit Review - With Images
**Status:** ⏳ Not Started
- Add 3 images to review
- **Expected:** Images uploaded and displayed
- **Actual:**

#### Test 7.8: Submit Review - Rating Updates Product
**Status:** ⏳ Not Started
- Submit 5-star review
- **Expected:** Product average rating updates
- **Actual:**

#### Test 7.9: Edit Existing Review
**Status:** ⏳ Not Started
- Edit previously submitted review
- **Expected:** Review updates successfully
- **Actual:**

#### Test 7.10: Vote Review Helpful
**Status:** ⏳ Not Started
- Click "Helpful" on a review
- **Expected:** Helpful count increments
- **Actual:**

#### Test 7.11: Report Review
**Status:** ⏳ Not Started
- Click "Report" on inappropriate review
- **Expected:** Review flagged, admin notified
- **Actual:**

#### Test 7.12: Filter Reviews by Rating
**Status:** ⏳ Not Started
- Click "5★" filter
- **Expected:** Only 5-star reviews show
- **Actual:**

#### Test 7.13: Review Pagination
**Status:** ⏳ Not Started
- Product with 20+ reviews
- **Expected:** Can load more reviews
- **Actual:**

---

## Final Summary

**Total Test Scenarios Created:** 128
**Tests Passed:** 0
**Tests Failed:** 0
**Tests Skipped:** 128 (not yet executed)

**Session Duration Estimate:**
- Documentation: 2-3 hours ✅
- Assessment & Bug Fixes: 3-4 hours ⏳
- Feature Implementation (3 features): 12-15 hours ⏳
- Testing: 3-4 hours ⏳
- **Total:** 20-26 hours

**Realistic Session Goal:**
- Complete documentation ✅
- Fix critical bugs to make app functional
- Implement 1-2 P0 features (Cart persistence, Search)
- Execute 50+ test scenarios
- Document roadmap for remaining features

---

**Document End**

This tracker will be updated in real-time as work progresses.