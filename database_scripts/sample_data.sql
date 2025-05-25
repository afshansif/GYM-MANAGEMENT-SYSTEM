-- Sample Data for Gym Management System

-- 1. Trainers
INSERT INTO Trainer (Id, FirstName, LastName, Specialization) VALUES
    ('11111111-1111-1111-1111-111111111111', 'John', 'Doe', 'Weight Training'),
    ('22222222-2222-2222-2222-222222222222', 'Jane', 'Smith', 'Yoga'),
    ('33333333-3333-3333-3333-333333333333', 'Mike', 'Johnson', 'CrossFit'),
    ('44444444-4444-4444-4444-444444444444', 'Sarah', 'Williams', 'Pilates');

-- 2. Members
INSERT INTO Member (Id, TrainerId, Username, Password, FirstName, LastName, RegistrationDate) VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'alice_g', 'pass123', 'Alice', 'Green', '2024-01-15 09:30:00'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', 'bob_t', 'pass456', 'Bob', 'Taylor', '2024-02-20 14:15:00'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333', 'charlie_b', 'pass789', 'Charlie', 'Brown', '2024-03-10 11:00:00'),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', NULL, 'diana_k', 'pass101', 'Diana', 'King', '2024-04-05 16:45:00');

-- 3. Subscription Plans
INSERT INTO SubscriptionPlan (Id, MemberId, TrainerId, Price, StartDate, EndDate, IsExpired) VALUES
    ('55555555-5555-5555-5555-555555555555', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, 59.99, '2024-01-15', '2024-07-15', FALSE),
    ('66666666-6666-6666-6666-666666666666', NULL, '11111111-1111-1111-1111-111111111111', 199.99, '2024-03-01', '2024-06-01', FALSE),
    ('77777777-7777-7777-7777-777777777777', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', NULL, 79.99, '2024-02-20', '2024-05-20', TRUE);

-- 4. Trainer Schedules
INSERT INTO TrainerSchedule (Id, TrainerId, StartTime, EndTime, Activity) VALUES
    ('88888888-8888-8888-8888-888888888888', '11111111-1111-1111-1111-111111111111', '2024-05-01 09:00:00', '2024-05-01 10:30:00', 'Personal Training'),
    ('99999999-9999-9999-9999-999999999999', '22222222-2222-2222-2222-222222222222', '2024-05-01 11:00:00', '2024-05-01 12:00:00', 'Yoga Class'),
    ('10101010-1010-1010-1010-101010101010', '33333333-3333-3333-3333-333333333333', '2024-05-02 17:00:00', '2024-05-02 18:30:00', 'CrossFit Session');

-- 5. Workout Plans
INSERT INTO WorkoutPlan (Id, MemberId, Content) VALUES
    ('20202020-2020-2020-2020-202020202020', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Monday: Chest/Triceps, Wednesday: Legs, Friday: Back/Biceps'),
    ('30303030-3030-3030-3030-303030303030', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Daily yoga routine with 30 min meditation');

-- 6. Diet Plans
INSERT INTO DietPlan (Id, MemberId, Content) VALUES
    ('40404040-4040-4040-4040-404040404040', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'High protein: 200g protein, 150g carbs, 50g fat'),
    ('50505050-5050-5050-5050-505050505050', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'Balanced: 150g protein, 200g carbs, 70g fat');

-- 7. Attendance Records
INSERT INTO AttendanceTracker (Id, MemberId, CheckInTime, Method) VALUES
    ('60606060-6060-6060-6060-606060606060', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2024-04-28 08:45:00', 'Mobile App'),
    ('70707070-7070-7070-7070-707070707070', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '2024-04-29 10:30:00', 'RFID Card'),
    ('80808080-8080-8080-8080-808080808080', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2024-04-30 17:15:00', 'Mobile App');

-- 8. Notifications
INSERT INTO Notification (Id, MemberId, Type, Content) VALUES
    ('90909090-9090-9090-9090-909090909090', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Payment', 'Your payment of $59.99 was received'),
    ('12121212-1212-1212-1212-121212121212', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Subscription', 'Your subscription will expire in 7 days');

-- 9. Payments
INSERT INTO PaymentIntegration (Id, MemberId, TrainerId, Amount, PaymentDate, IsSuccessful) VALUES
    ('13131313-1313-1313-1313-131313131313', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL, 59.99, '2024-04-01 00:00:00', TRUE),
    ('14141414-1414-1414-1414-141414141414', NULL, '11111111-1111-1111-1111-111111111111', 199.99, '2024-04-15 00:00:00', TRUE);

-- 10. Reports
INSERT INTO Report (Id, Date, DailyAttendance, Income, MemberCount, IsGenerated, TrainerCount) VALUES
    ('15151515-1515-1515-1515-151515151515', '2024-04-30 23:59:59', 42, 1250.50, 150, TRUE, 8);