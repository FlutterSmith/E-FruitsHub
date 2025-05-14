# Product Requirements Document (PRD)
# Fruits Hub - E-Commerce Enhancement

**Version:** 1.0
**Date:** 2025-11-01
**Status:** Planning Phase

---

## Executive Summary

Fruits Hub is a Flutter-based e-commerce mobile application for purchasing fresh vegetables and fruits. This PRD outlines comprehensive feature enhancements to transform the app from a basic shopping platform into a fully-featured, competitive e-commerce solution with advanced customer retention, monetization, and operational capabilities.

### User Roles
- **Normal User**: Standard customer account with basic shopping features
- **Premium User**: Subscription-based account with exclusive benefits
- **Admin**: Backend management role for operations, analytics, and content

---

## Phase 1: Critical Foundation Features (P0)

### 1.1 Persistent Shopping Cart
**Priority:** P0 - Critical
**User Story:** As a customer, I want my cart to persist across sessions so I don't lose my selections when I close the app.

**Requirements:**
- Cart synced to Firestore in real-time under user's account
- Cart items persist across app restarts and device changes
- Merge cart logic: combine local cart with cloud cart on login
- Display last updated timestamp
- Handle out-of-stock items gracefully (show warning, allow removal)

**Firestore Schema:**
```
carts/{userId}/items/{productId}
  - productId: string
  - quantity: number
  - addedAt: timestamp
  - lastModified: timestamp
```

**Acceptance Criteria:**
- ✅ Cart saves to Firestore within 500ms of any change
- ✅ Cart loads on app launch if user authenticated
- ✅ Cart merges correctly when logging in with local items
- ✅ Out-of-stock items show warning badge
- ✅ Offline changes sync when connection restored

---

### 1.2 Advanced Search & Filters
**Priority:** P0 - Critical
**User Story:** As a customer, I want to quickly find specific products using search and filters.

**Requirements:**
- Real-time search with debouncing (300ms delay)
- Search across: product name, description, category, tags
- Filters:
  - Price range (slider with min/max)
  - Category (multi-select)
  - Rating (stars: 1+, 2+, 3+, 4+)
  - Availability (in stock, on sale, best sellers)
  - Sort by: Price (low-high, high-low), Rating, Newest, Popular
- Search history (last 10 searches) with clear option
- "No results" state with suggested products
- Search analytics tracking

**UI/UX:**
- Floating search bar at top of product list
- Filter drawer/bottom sheet with apply/reset buttons
- Active filter chips displayed below search bar
- Search results highlight matching text

**Acceptance Criteria:**
- ✅ Search returns results within 500ms
- ✅ Filters combine with AND logic (all must match)
- ✅ Filter count badge shows active filter count
- ✅ Clear all filters button resets to default view
- ✅ Search history persists locally

---

### 1.3 Product Reviews & Ratings System
**Priority:** P0 - Critical
**User Story:** As a customer, I want to read and write product reviews to make informed purchasing decisions.

**Requirements:**
- 5-star rating system with half-star support
- Written reviews with 50-500 character limit
- Review submission only after order delivered
- One review per product per user (can edit)
- Review display: newest first, with pagination
- Review voting: helpful/not helpful
- Report inappropriate reviews
- Average rating calculation and display
- Review images (optional, up to 3 photos)
- Filter reviews: All Stars, 5★, 4★, 3★, 2★, 1★

**Firestore Schema:**
```
products/{productId}/reviews/{reviewId}
  - userId: string
  - userName: string
  - userPhoto: string
  - rating: number (1-5)
  - comment: string
  - images: array[string] (URLs)
  - createdAt: timestamp
  - updatedAt: timestamp
  - helpfulCount: number
  - reportCount: number
  - orderId: string (proof of purchase)
```

**Acceptance Criteria:**
- ✅ Only verified purchasers can review
- ✅ Average rating updates in real-time
- ✅ Review submission validated (character limits)
- ✅ Images compressed before upload (max 1MB each)
- ✅ Reported reviews flagged for admin review

---

### 1.4 Multiple Delivery Addresses
**Priority:** P0 - Critical
**User Story:** As a customer, I want to save multiple delivery addresses for convenient checkout.

**Requirements:**
- Add/edit/delete addresses
- Set one address as default
- Address form fields:
  - Label (Home, Work, Other)
  - Full name
  - Phone number
  - Street address
  - City
  - State/Province
  - Postal code
  - Delivery instructions (optional)
- Address validation (required fields)
- Select address during checkout
- Recent addresses (last 3 used) highlighted

**Firestore Schema:**
```
users/{userId}/addresses/{addressId}
  - label: string
  - fullName: string
  - phone: string
  - street: string
  - city: string
  - state: string
  - postalCode: string
  - instructions: string
  - isDefault: boolean
  - lastUsed: timestamp
  - createdAt: timestamp
```

**Acceptance Criteria:**
- ✅ Maximum 5 saved addresses per user
- ✅ Default address pre-selected at checkout
- ✅ Phone number validation (format check)
- ✅ Postal code validation
- ✅ Delete confirmation prompt

---

### 1.5 Multiple Payment Methods
**Priority:** P0 - Critical
**User Story:** As a customer, I want to choose from various payment methods at checkout.

**Requirements:**
- Payment options:
  - Cash on Delivery (COD)
  - Credit/Debit Card (Stripe integration)
  - Digital Wallet (Apple Pay, Google Pay)
  - In-app Wallet (prepaid balance)
- Save card details for future use (tokenized)
- Set default payment method
- Payment method icons and clear labels
- Transaction security (SSL, PCI compliance)
- Payment confirmation screen
- Failed payment retry flow

**Firestore Schema:**
```
users/{userId}/paymentMethods/{methodId}
  - type: string (card, wallet, cod)
  - label: string
  - lastFourDigits: string (for cards)
  - cardBrand: string (Visa, Mastercard, etc.)
  - expiryMonth: number
  - expiryYear: number
  - isDefault: boolean
  - stripeToken: string
  - createdAt: timestamp
```

**Acceptance Criteria:**
- ✅ Stripe integration for card payments
- ✅ Cards stored securely (tokenized only)
- ✅ COD available for orders under $200
- ✅ Payment failure shows clear error message
- ✅ Receipt sent via email after successful payment

---

## Phase 2: Customer Retention Features (P1)

### 2.1 Push Notifications
**Priority:** P1 - High
**User Story:** As a customer, I want to receive timely updates about my orders and special offers.

**Requirements:**
- Firebase Cloud Messaging (FCM) integration
- Notification types:
  - Order status updates (confirmed, shipped, delivered)
  - Promotional offers and discounts
  - New product arrivals
  - Cart reminders (abandoned cart after 24h)
  - Price drop alerts for wishlist items
  - Review requests after delivery
- Notification preferences in settings
- In-app notification center
- Deep linking to relevant screens
- Notification badge count on app icon

**Acceptance Criteria:**
- ✅ Notifications delivered within 30 seconds
- ✅ User can disable specific notification types
- ✅ Deep links navigate to correct screen
- ✅ Notification history stored for 30 days
- ✅ Badge count updates accurately

---

### 2.2 Promo Codes & Discounts
**Priority:** P1 - High
**User Story:** As a customer, I want to apply promo codes to get discounts on my purchases.

**Requirements:**
- Admin creates promo codes with conditions
- Promo types:
  - Percentage off (e.g., 20% off)
  - Fixed amount off (e.g., $10 off)
  - Free shipping
  - Buy X Get Y free
  - Category-specific discounts
- Code validation:
  - Expiration date check
  - Minimum order value check
  - Usage limit (total and per user)
  - First-time user only codes
  - Premium user exclusive codes
- Apply code at checkout
- Auto-apply best available code
- Code history in user profile

**Firestore Schema:**
```
promoCodes/{codeId}
  - code: string (unique)
  - type: string (percentage, fixed, shipping, bogo)
  - value: number
  - minOrderValue: number
  - maxDiscount: number
  - expiresAt: timestamp
  - usageLimit: number
  - usedCount: number
  - perUserLimit: number
  - userType: string (all, new, premium)
  - categories: array[string]
  - isActive: boolean
  - createdAt: timestamp
```

**Acceptance Criteria:**
- ✅ Invalid codes show clear error message
- ✅ Code applied before taxes calculation
- ✅ One code per order limit enforced
- ✅ Expired codes automatically deactivated
- ✅ Usage tracking prevents fraud

---

### 2.3 Loyalty Points Program
**Priority:** P1 - High
**User Story:** As a customer, I want to earn points on purchases and redeem them for rewards.

**Requirements:**
- Earn points: 1 point per $1 spent
- Bonus points for:
  - First order: 100 points
  - Referral success: 200 points
  - Product review: 10 points
  - Birthday month: 2x points
- Redeem points: 100 points = $1 discount
- Points expiry: 1 year from earn date
- Points ledger showing earn/redeem history
- Points balance displayed on profile
- Tier system:
  - Bronze: 0-999 points (1x earn rate)
  - Silver: 1000-2999 points (1.2x earn rate)
  - Gold: 3000+ points (1.5x earn rate)
- Tier badges and exclusive perks

**Firestore Schema:**
```
users/{userId}/pointsLedger/{transactionId}
  - type: string (earn, redeem, expire)
  - points: number
  - reason: string
  - orderId: string (optional)
  - createdAt: timestamp
  - expiresAt: timestamp

users/{userId}
  - pointsBalance: number
  - pointsTier: string (bronze, silver, gold)
  - lifetimePoints: number
```

**Acceptance Criteria:**
- ✅ Points credited within 24h of order delivery
- ✅ Expiring points show warning 30 days before
- ✅ Tier badges display on profile
- ✅ Points balance updates in real-time
- ✅ Redemption minimum 100 points

---

### 2.4 Wishlist / Favorites
**Priority:** P1 - High
**User Story:** As a customer, I want to save products to my wishlist for later purchase.

**Requirements:**
- Add/remove products to wishlist
- Wishlist accessible from profile tab
- Heart icon on product cards (filled if in wishlist)
- Move wishlist item to cart with one tap
- Price drop notifications for wishlist items
- Share wishlist via link
- Wishlist item count badge
- Availability status on wishlist items
- Remove unavailable items option

**Firestore Schema:**
```
users/{userId}/wishlist/{productId}
  - productId: string
  - addedAt: timestamp
  - notifyOnPriceDrop: boolean
  - notifyOnAvailable: boolean
```

**Acceptance Criteria:**
- ✅ Wishlist syncs across devices
- ✅ Heart icon updates immediately on tap
- ✅ Wishlist limit of 50 items
- ✅ Price drop notifications sent within 1 hour
- ✅ Shared wishlist link valid for 7 days

---

### 2.5 Referral Program
**Priority:** P1 - High
**User Story:** As a customer, I want to invite friends and earn rewards when they make purchases.

**Requirements:**
- Unique referral code per user
- Share referral via:
  - SMS
  - WhatsApp
  - Email
  - Social media (Facebook, Instagram)
  - Copy link
- Referral rewards:
  - Referrer: 200 points when referee makes first order
  - Referee: $10 off first order over $50
- Referral tracking:
  - Pending referrals (signed up, not purchased)
  - Successful referrals (first order completed)
  - Total rewards earned
- Referral leaderboard (optional social feature)
- Fraud detection (same device, IP blocking)

**Firestore Schema:**
```
users/{userId}
  - referralCode: string (unique)
  - referredBy: string (userId of referrer)
  - referralCount: number
  - referralPoints: number

referrals/{referralId}
  - referrerId: string
  - refereeId: string
  - status: string (pending, completed, expired)
  - createdAt: timestamp
  - completedAt: timestamp
  - rewardGranted: boolean
```

**Acceptance Criteria:**
- ✅ Referral code unique and memorable (6 chars)
- ✅ Referee discount auto-applied on first order
- ✅ Referrer points credited after referee's order delivered
- ✅ Self-referral prevented
- ✅ Referral link tracks source attribution

---

## Phase 3: Premium Features (P1)

### 3.1 Premium Subscription
**Priority:** P1 - High
**User Story:** As a customer, I want to subscribe to premium for exclusive benefits.

**Requirements:**
- Subscription tiers:
  - **Premium Monthly**: $9.99/month
  - **Premium Annual**: $99/year (save 17%)
- Premium benefits:
  - Free shipping on all orders
  - 5% cashback on all purchases
  - Early access to new products (24h before public)
  - Exclusive promo codes
  - Priority customer support
  - Extended return window (30 days vs 7 days)
- Subscription management:
  - Upgrade/downgrade
  - Cancel anytime (prorated refund)
  - Auto-renewal with reminder 7 days before
  - Payment method for subscription
- Premium badge on profile
- Family sharing (add up to 3 family members)

**Firestore Schema:**
```
users/{userId}/subscription
  - tier: string (monthly, annual)
  - status: string (active, cancelled, expired)
  - startDate: timestamp
  - expiryDate: timestamp
  - autoRenew: boolean
  - paymentMethodId: string
  - familyMembers: array[userId]
  - totalSavings: number
```

**Acceptance Criteria:**
- ✅ Premium benefits activate immediately on payment
- ✅ Cancelled subscription runs until expiry date
- ✅ Auto-renewal reminder email sent 7 days prior
- ✅ Family members inherit all premium benefits
- ✅ Savings tracker shows total amount saved

---

### 3.2 Subscription Boxes
**Priority:** P1 - High
**User Story:** As a customer, I want to subscribe to weekly produce boxes for convenience.

**Requirements:**
- Subscription box types:
  - **Veggie Box**: Seasonal vegetables ($29/week)
  - **Fruit Box**: Fresh fruits ($34/week)
  - **Mixed Box**: Vegetables + fruits ($49/week)
  - **Organic Box**: Certified organic produce ($59/week)
- Box customization:
  - Exclude specific items (allergies, preferences)
  - Quantity: Small (2 people), Medium (4 people), Large (6 people)
  - Delivery frequency: Weekly, Bi-weekly, Monthly
- Subscription management:
  - Skip next delivery
  - Pause subscription (up to 3 months)
  - Change box type or frequency
  - Cancel anytime (7 days notice required)
- Surprise element: "Chef's Pick" items each week
- Recipe cards included with each box
- Delivery day selection (weekdays only)

**Firestore Schema:**
```
users/{userId}/subscriptionBoxes/{boxId}
  - boxType: string (veggie, fruit, mixed, organic)
  - size: string (small, medium, large)
  - frequency: string (weekly, biweekly, monthly)
  - price: number
  - excludedItems: array[string]
  - deliveryDay: string
  - nextDeliveryDate: timestamp
  - status: string (active, paused, cancelled)
  - pausedUntil: timestamp
  - createdAt: timestamp
```

**Acceptance Criteria:**
- ✅ First box delivered within 7 days of signup
- ✅ Skip option available up to 2 days before delivery
- ✅ Excluded items respected in all boxes
- ✅ Recipe cards match box contents
- ✅ Cancellation confirmation email sent

---

## Phase 4: Enhanced Shopping Experience (P1-P2)

### 4.1 Real-Time Order Tracking
**Priority:** P1 - High
**User Story:** As a customer, I want to track my order's location in real-time.

**Requirements:**
- Order status updates:
  - Order Placed
  - Payment Confirmed
  - Processing/Packing
  - Out for Delivery (with driver details)
  - Delivered
- Real-time map showing delivery driver location
- Estimated delivery time (dynamic, updates based on traffic)
- Driver contact: call/message (anonymized numbers)
- Push notifications for each status change
- Photo proof of delivery (driver uploads)
- Delivery signature capture (optional)
- Order timeline view with timestamps

**Integration:**
- Google Maps API for real-time tracking
- Firebase Realtime Database for live location updates
- Twilio for SMS notifications (optional)

**Firestore Schema:**
```
orders/{orderId}/tracking
  - currentStatus: string
  - driverId: string
  - driverName: string
  - driverPhone: string
  - driverLocation: geopoint (updates every 30s)
  - estimatedDelivery: timestamp
  - statusHistory: array[{status, timestamp}]
  - deliveryPhoto: string (URL)
  - signature: string (base64 or URL)
```

**Acceptance Criteria:**
- ✅ Map updates driver location every 30 seconds
- ✅ ETA accuracy within 15 minutes
- ✅ Photo proof uploaded before "Delivered" status
- ✅ Driver contact works without revealing real numbers
- ✅ Status notifications sent within 1 minute

---

### 4.2 Quick Reorder
**Priority:** P2 - Medium
**User Story:** As a customer, I want to quickly reorder items from previous orders.

**Requirements:**
- "Reorder" button on past orders
- Reorder entire order with one tap
- Reorder individual items from order
- Check item availability before adding
- Show price changes since original order
- "Frequently Bought" section on home screen
- "Buy Again" smart suggestions based on purchase history

**Acceptance Criteria:**
- ✅ Reorder adds all available items to cart
- ✅ Out-of-stock items listed separately with alternatives
- ✅ Price changes highlighted (increased/decreased)
- ✅ Frequently bought shows last 30 days
- ✅ Buy again limited to 10 items

---

### 4.3 Personalized Recommendations
**Priority:** P2 - Medium
**User Story:** As a customer, I want to see product recommendations based on my preferences.

**Requirements:**
- Recommendation algorithms:
  - Collaborative filtering (users like you bought)
  - Content-based (similar to items you liked)
  - Purchase history patterns
  - Trending products
  - Seasonal recommendations
- Recommendation sections:
  - "Recommended for You" on home screen
  - "Customers Also Bought" on product page
  - "Complete Your Cart" at checkout
  - "You Might Like" after order placed
- ML model training on:
  - Purchase history
  - Browsing history
  - Wishlist items
  - Cart items (current and abandoned)
  - Search queries
  - Ratings and reviews

**Acceptance Criteria:**
- ✅ Recommendations update daily
- ✅ At least 6 recommendations shown
- ✅ Accuracy improves over time (A/B testing)
- ✅ New users see trending/popular items
- ✅ Privacy-compliant (no personal data leakage)

---

## Phase 5: Financial Features (P1-P2)

### 5.1 In-App Wallet
**Priority:** P1 - High
**User Story:** As a customer, I want a wallet to store funds for faster checkout and receive refunds.

**Requirements:**
- Wallet balance displayed on profile
- Add money to wallet:
  - Credit/Debit card
  - Net banking
  - UPI (India-specific)
  - Minimum: $10, Maximum: $500 per transaction
- Use wallet for:
  - Order payment (full or partial)
  - Combine with other payment methods
- Wallet transactions:
  - Money added
  - Order payment deducted
  - Refunds credited
  - Cashback received
  - Loyalty points redeemed
- Transaction history with filters (date range, type)
- Wallet security: PIN protection, biometric unlock
- Auto-add money when balance low (optional)

**Firestore Schema:**
```
users/{userId}/wallet
  - balance: number
  - currency: string
  - isPinSet: boolean
  - autoAddEnabled: boolean
  - autoAddThreshold: number
  - autoAddAmount: number

users/{userId}/walletTransactions/{transactionId}
  - type: string (credit, debit)
  - amount: number
  - reason: string
  - orderId: string (optional)
  - balanceAfter: number
  - createdAt: timestamp
  - status: string (success, pending, failed)
```

**Acceptance Criteria:**
- ✅ Money added reflects within 5 seconds
- ✅ Wallet cannot go negative
- ✅ Transaction history downloadable as PDF
- ✅ PIN required for wallet payments over $50
- ✅ Refunds credited within 3-5 business days

---

### 5.2 Export Invoices / Reports
**Priority:** P2 - Medium
**User Story:** As a customer, I want to download invoices and spending reports for record-keeping.

**Requirements:**
- Download invoice for each order (PDF)
- Invoice details:
  - Order ID, date, billing/shipping address
  - Itemized list with quantities and prices
  - Subtotal, taxes, shipping, discount, total
  - Payment method
  - GST/VAT number (if applicable)
  - Company logo and support contact
- Spending reports:
  - Monthly spending summary
  - Category-wise breakdown (pie chart)
  - Year-to-date total
  - Tax summary for business users
  - Export as PDF or CSV
- Email invoice option
- Bulk download (select multiple orders)

**Acceptance Criteria:**
- ✅ Invoice generated within 24h of order placement
- ✅ PDF formatted professionally (A4 size)
- ✅ Reports accurate and match order history
- ✅ CSV exports open correctly in Excel
- ✅ Email delivery within 5 minutes

---

## Phase 6: Support Features (P1)

### 6.1 Live Chat Support
**Priority:** P1 - High
**User Story:** As a customer, I want to chat with support for quick help.

**Requirements:**
- In-app chat widget
- Chat features:
  - Real-time messaging
  - File/image sharing (order issues)
  - Typing indicators
  - Read receipts
  - Chat history (last 30 days)
  - Rate conversation after resolution
- Support hours: 9 AM - 9 PM (local time)
- Outside hours: Leave message, receive email reply
- Priority support for Premium users (shorter wait time)
- Auto-responses for common questions
- Transfer to human agent option
- Order lookup integration (agent sees order details)

**Integration:**
- Firebase Realtime Database for real-time chat
- Cloud Functions for auto-responses
- Admin dashboard for agents

**Firestore Schema:**
```
chats/{chatId}
  - userId: string
  - agentId: string
  - status: string (open, closed, waiting)
  - createdAt: timestamp
  - closedAt: timestamp
  - rating: number
  - feedback: string

chats/{chatId}/messages/{messageId}
  - senderId: string
  - senderType: string (user, agent, bot)
  - message: string
  - attachments: array[string]
  - timestamp: timestamp
  - read: boolean
```

**Acceptance Criteria:**
- ✅ Messages delivered within 2 seconds
- ✅ Average wait time < 3 minutes (business hours)
- ✅ Premium users prioritized in queue
- ✅ 90% of chats rated 4+ stars
- ✅ Auto-close inactive chats after 24h

---

### 6.2 Order Issues / Returns
**Priority:** P1 - High
**User Story:** As a customer, I want to report issues and initiate returns easily.

**Requirements:**
- Report issue types:
  - Damaged product
  - Wrong item delivered
  - Missing items
  - Quality issues
  - Late delivery
  - Other (free text)
- Issue reporting flow:
  - Select order and item
  - Choose issue type
  - Upload photos (up to 5)
  - Describe issue (50-500 chars)
  - Select resolution: Refund, Replacement, Store Credit
- Return eligibility:
  - Within 7 days of delivery (30 days for Premium)
  - Product in original condition
  - Perishables not eligible (unless damaged)
- Return process:
  - Generate return label
  - Schedule pickup (free for issues, $5 for change-of-mind)
  - Track return shipment
  - Refund processed after inspection (3-5 days)
- Issue history in profile
- Admin dashboard for issue management

**Firestore Schema:**
```
orders/{orderId}/issues/{issueId}
  - userId: string
  - itemId: string
  - issueType: string
  - description: string
  - photos: array[string]
  - resolution: string (refund, replacement, credit)
  - status: string (reported, investigating, resolved, rejected)
  - createdAt: timestamp
  - resolvedAt: timestamp
  - refundAmount: number
  - adminNotes: string
```

**Acceptance Criteria:**
- ✅ Issue reported in < 2 minutes
- ✅ Admin response within 24 hours
- ✅ Refund processed within 5 business days
- ✅ Pickup scheduled within 48 hours
- ✅ Photos required for damage claims

---

## Phase 7: Content Features (P3)

### 7.1 Recipe Suggestions
**Priority:** P3 - Low
**User Story:** As a customer, I want recipe ideas based on products I purchase.

**Requirements:**
- Recipe database with:
  - Recipe name and description
  - Ingredients with quantities
  - Step-by-step instructions
  - Prep time, cook time, servings
  - Difficulty level
  - Photos of finished dish
  - Nutritional information
  - User ratings and reviews
- Recipe recommendations:
  - Based on cart items
  - Based on purchased products
  - Seasonal recipes
  - Trending recipes
  - Category filters (breakfast, lunch, dinner, snacks)
- "Add Ingredients to Cart" button
- Save favorite recipes
- Share recipes via social media
- Video tutorials (optional, future phase)

**Firestore Schema:**
```
recipes/{recipeId}
  - name: string
  - description: string
  - ingredients: array[{productId, name, quantity, unit}]
  - instructions: array[string]
  - prepTime: number (minutes)
  - cookTime: number (minutes)
  - servings: number
  - difficulty: string (easy, medium, hard)
  - images: array[string]
  - videoUrl: string
  - tags: array[string]
  - averageRating: number
  - reviewCount: number

users/{userId}/favoriteRecipes/{recipeId}
  - recipeId: string
  - savedAt: timestamp
```

**Acceptance Criteria:**
- ✅ Recipe database has 100+ recipes at launch
- ✅ Add ingredients adds all items to cart
- ✅ Recipe search works across all fields
- ✅ Favorites sync across devices
- ✅ Recipes load in < 1 second

---

## Phase 8: Admin Dashboard (P0)

### 8.1 Comprehensive Admin Panel
**Priority:** P0 - Critical
**User Story:** As an admin, I want a web dashboard to manage all operations.

**Requirements:**

#### Dashboard Home:
- Key metrics cards:
  - Total revenue (today, week, month, year)
  - Total orders (today, pending, processing, completed)
  - Total users (active, new today, premium)
  - Average order value
  - Top selling products (last 30 days)
  - Low stock alerts
- Revenue chart (daily/weekly/monthly view)
- Order status breakdown (pie chart)
- Recent activity feed

#### Product Management:
- Product CRUD operations (Create, Read, Update, Delete)
- Bulk import via CSV
- Image upload (multiple per product)
- Inventory management (stock levels, low stock alerts)
- Pricing and discount management
- Product variants (size, weight options)
- Category and tag management
- SEO fields (meta description, keywords)
- Product visibility toggle (hide/show)

#### Order Management:
- Order list with filters:
  - Status (pending, processing, shipped, delivered, cancelled)
  - Date range
  - Payment method
  - Price range
- Order details view
- Update order status with notes
- Print packing slips
- Bulk status updates
- Refund processing
- Order export (CSV, PDF)

#### User Management:
- User list with search and filters
- User details: profile, orders, reviews, wallet, points
- Grant/revoke Premium status
- Block/unblock users
- Send push notifications to users
- User segmentation (new, active, churned)
- Export user data

#### Analytics & Reports:
- Sales reports (daily, weekly, monthly, custom range)
- Product performance (sales, revenue, returns)
- Customer analytics (LTV, retention, churn)
- Traffic sources and conversions
- Promo code effectiveness
- Loyalty program metrics
- Subscription analytics
- Export all reports as PDF/CSV

#### Content Management:
- Homepage banner management
- Featured products curation
- Promo code creation and management
- Recipe creation and management
- Category management
- FAQ management
- Push notification composer

#### Support & Issues:
- Live chat agent interface
- Issue/return requests queue
- Issue resolution workflow
- Customer support tickets
- Canned responses library

**Tech Stack:**
- Next.js admin dashboard (separate web app)
- Firebase Admin SDK for backend operations
- Charts: Recharts or Chart.js
- UI: shadcn/ui components
- Authentication: Firebase Admin Auth

**Acceptance Criteria:**
- ✅ Dashboard loads in < 2 seconds
- ✅ All CRUD operations work correctly
- ✅ Charts update in real-time
- ✅ Export functions generate correct data
- ✅ Mobile-responsive design
- ✅ Role-based access control (super admin, admin, support agent)

---

## Technical Requirements

### Performance
- App startup time < 3 seconds
- Product list load time < 1 second
- Search results < 500ms
- Image loading optimized (lazy load, CDN, compression)
- Offline support for browsing (cached data)
- Smooth 60fps animations

### Security
- Firebase Security Rules enforced
- User data encrypted in transit (HTTPS)
- Sensitive data encrypted at rest
- PCI DSS compliance for payments
- Regular security audits
- Rate limiting on API calls
- Input validation and sanitization

### Scalability
- Firestore indexes optimized for all queries
- Cloud Functions for heavy operations
- CDN for image and static asset delivery
- Database sharding for large collections
- Caching strategy (Redis or Firebase Hosting CDN)

### Analytics & Tracking
- Firebase Analytics integration
- Track key events:
  - App opens, user sessions
  - Product views, searches
  - Add to cart, checkout started, purchase
  - Review submissions, referrals
  - Push notification interactions
- Custom user properties (premium status, tier, LTV)
- Conversion funnel analysis
- Crash reporting (Firebase Crashlytics)

---

## Success Metrics

### Engagement Metrics:
- Daily Active Users (DAU) / Monthly Active Users (MAU)
- Session duration: target 5+ minutes
- Cart abandonment rate: reduce to < 30%
- Return user rate: target 40%+

### Business Metrics:
- Gross Merchandise Value (GMV)
- Average Order Value (AOV): target $35+
- Customer Lifetime Value (LTV): target $300+
- Premium subscription conversion: target 5%
- Referral conversion rate: target 15%

### Quality Metrics:
- App crash rate: < 0.1%
- API error rate: < 0.5%
- Customer satisfaction (CSAT): target 4.5/5
- Net Promoter Score (NPS): target 50+
- Review rating average: target 4.2/5

---

## Release Plan

### Phase 1 (Weeks 1-4): Foundation
- Persistent Cart
- Search & Filters
- Reviews & Ratings
- Multiple Addresses
- Multiple Payment Methods

### Phase 2 (Weeks 5-8): Retention
- Push Notifications
- Promo Codes
- Loyalty Points
- Wishlist
- Referral Program

### Phase 3 (Weeks 9-11): Premium
- Premium Subscription
- Subscription Boxes

### Phase 4 (Weeks 12-14): Experience
- Order Tracking
- Quick Reorder
- Personalized Recommendations

### Phase 5 (Weeks 15-17): Financial
- In-App Wallet
- Invoice Export

### Phase 6 (Weeks 18-20): Support
- Live Chat
- Returns/Issues

### Phase 7 (Week 21): Content
- Recipe Suggestions

### Phase 8 (Ongoing): Admin
- Admin Dashboard (parallel development)

**Total Timeline:** 21 weeks (~5 months)

---

## Appendix

### Dependencies to Add:
```yaml
# Flutter packages
- firebase_messaging: ^14.0.0  # Push notifications
- firebase_dynamic_links: ^5.0.0  # Deep linking, referrals
- stripe_flutter: ^9.0.0  # Payment processing
- google_maps_flutter: ^2.0.0  # Order tracking
- share_plus: ^7.0.0  # Sharing (recipes, wishlist, referrals)
- image_picker: ^1.0.0  # Review photos, issue photos
- pdf: ^3.10.0  # Invoice generation
- csv: ^5.0.0  # Data export
- fl_chart: ^0.60.0  # Analytics charts (admin)
- socket_io_client: ^2.0.0  # Live chat (alternative to Firebase)
```

### API Integrations:
- Stripe (payment processing)
- Google Maps API (order tracking)
- SendGrid or Firebase Email (transactional emails)
- Twilio (SMS notifications - optional)
- Firebase Cloud Functions (backend logic)

---

**Document End**