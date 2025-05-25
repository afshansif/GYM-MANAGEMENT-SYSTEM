-- 1. Member Subscriptions View
CREATE OR REPLACE VIEW view_member_subscriptions AS
SELECT 
    m.Id AS MemberId,
    m.FirstName AS MemberFirstName,
    m.LastName AS MemberLastName,
    sp.Id AS SubscriptionPlanId,
    sp.Price,
    sp.StartDate,
    sp.EndDate,
    sp.IsExpired
FROM 
    Member m
JOIN 
    SubscriptionPlan sp ON m.Id = sp.MemberId;

-- 2. Payment Details View
CREATE OR REPLACE VIEW view_payment_details AS
SELECT 
    pi.Id AS PaymentId,
    m.Id AS MemberId,
    m.FirstName AS MemberFirstName,
    m.LastName AS MemberLastName,
    pi.Amount,
    pi.PaymentDate,
    pi.IsSuccessful
FROM 
    PaymentIntegration pi
JOIN 
    Member m ON pi.MemberId = m.Id;

-- 3. Member Attendance View

CREATE OR REPLACE VIEW view_member_attendance AS
SELECT 
    at.Id AS AttendanceId,
    m.Id AS MemberId,
    m.FirstName AS MemberFirstName,
    m.LastName AS MemberLastName,
    at.CheckInTime,
    at.Method
FROM 
    AttendanceTracker at
JOIN 
    Member m ON at.MemberId = m.Id;

-- 4. Member Workouts View
CREATE OR REPLACE VIEW view_member_workouts AS
SELECT 
    wp.Id AS WorkoutPlanId,
    m.Id AS MemberId,
    m.FirstName AS MemberFirstName,
    m.LastName AS MemberLastName,
    wp.Content AS WorkoutDetails
FROM 
    WorkoutPlan wp
JOIN 
    Member m ON wp.MemberId = m.Id;

-- 5. Notifications Sent View
CREATE OR REPLACE VIEW view_notifications_sent AS
SELECT 
    n.Id AS NotificationId,
    m.Id AS MemberId,
    m.FirstName AS MemberFirstName,
    m.LastName AS MemberLastName,
    n.Type AS NotificationType,
    n.Content,
    n.SentDate
FROM 
    Notification n
JOIN 
    Member m ON n.MemberId = m.Id;

-- =============================================
-- MATERIALIZED VIEWS
-- =============================================

-- 1. Daily Report Summary
CREATE MATERIALIZED VIEW mv_daily_report_summary AS
SELECT 
    r.Date,
    r.DailyAttendance,
    r.Income,
    r.MemberCount,
    r.TrainerCount
FROM 
    Report r
WHERE 
    r.IsGenerated = TRUE;

-- 2. Active Members
CREATE MATERIALIZED VIEW mv_active_members AS
SELECT 
    m.Id AS MemberId,
    m.FirstName AS MemberFirstName,
    m.LastName AS MemberLastName,
    MAX(at.CheckInTime) AS LastCheckIn
FROM 
    Member m
JOIN 
    AttendanceTracker at ON m.Id = at.MemberId
WHERE 
    at.CheckInTime >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY 
    m.Id, m.FirstName, m.LastName;

-- 3. Total Income Per Member
CREATE MATERIALIZED VIEW mv_total_income_per_member AS
SELECT 
    m.Id AS MemberId,
    m.FirstName AS MemberFirstName,
    m.LastName AS MemberLastName,
    SUM(pi.Amount) AS TotalPaid
FROM 
    Member m
JOIN 
    PaymentIntegration pi ON m.Id = pi.MemberId
WHERE 
    pi.IsSuccessful = TRUE
GROUP BY 
    m.Id, m.FirstName, m.LastName;

-- 4. Trainer Schedules
CREATE MATERIALIZED VIEW mv_trainer_schedules AS
SELECT 
    t.Id AS TrainerId,
    t.FirstName AS TrainerFirstName,
    t.LastName AS TrainerLastName,
    ts.Id AS ScheduleId,
    ts.StartTime,
    ts.EndTime,
    ts.Activity
FROM 
    Trainer t
JOIN 
    TransferSchedule ts ON t.Id = ts.TrainerId
WHERE 
    ts.EndTime > CURRENT_TIMESTAMP;

-- 5. Subscription Status
CREATE MATERIALIZED VIEW mv_subscription_status AS
SELECT 
    sp.Id AS SubscriptionId,
    m.Id AS MemberId,
    m.FirstName AS MemberFirstName,
    m.LastName AS MemberLastName,
    sp.StartDate,
    sp.EndDate,
    sp.IsExpired
FROM 
    SubscriptionPlan sp
JOIN 
    Member m ON sp.MemberId = m.Id;
