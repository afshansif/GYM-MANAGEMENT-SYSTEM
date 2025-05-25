-- 1. Add New Member
CREATE OR REPLACE PROCEDURE add_new_member(
    p_username VARCHAR(255),
    p_password VARCHAR(255),
    p_first_name VARCHAR(255),
    p_last_name VARCHAR(255),
    p_trainer_id UUID DEFAULT NULL
)
LANGUAGE SQL
AS $$
    INSERT INTO Member (
        Id, 
        trainerId, 
        Username, 
        Password, 
        FirstName, 
        LastName, 
        RegistrationDate
    )
    VALUES (
        gen_random_uuid(), 
        p_trainer_id, 
        p_username, 
        p_password, 
        p_first_name, 
        p_last_name, 
        CURRENT_TIMESTAMP
    );
$$;

-- 2. Update Subscription Status
CREATE OR REPLACE PROCEDURE update_subscription_status()
LANGUAGE SQL
AS $$
    UPDATE SubscriptionPlan
    SET IsExpired = TRUE
    WHERE EndDate < CURRENT_DATE
    AND IsExpired = FALSE;
$$;

-- 3. Record Attendance
CREATE OR REPLACE PROCEDURE record_attendance(
    p_member_id UUID,
    p_method VARCHAR(255)
	)
LANGUAGE SQL
AS $$
    INSERT INTO AttendanceTracker (
        Id, 
        MemberId, 
        CheckInTime, 
        Method
    )
    VALUES (
        gen_random_uuid(), 
        p_member_id, 
        CURRENT_TIMESTAMP, 
        p_method
    );
$$;

-- 4. Generate Daily Report
CREATE OR REPLACE PROCEDURE generate_daily_report()
LANGUAGE SQL
AS $$
    INSERT INTO Report (
        Id, 
        Date, 
        DailyAttendance, 
        Income, 
        MemberCount, 
        IsGenerated, 
        TrainerCount
    )
    SELECT 
        gen_random_uuid(),
        CURRENT_DATE,
        (SELECT COUNT(DISTINCT MemberId) FROM AttendanceTracker WHERE DATE(CheckInTime) = CURRENT_DATE),
        (SELECT COALESCE(SUM(Amount), 0) FROM PaymentIntegration WHERE DATE(PaymentDate) = CURRENT_DATE AND IsSuccessful = TRUE),
        (SELECT COUNT(*) FROM Member),
        TRUE,
        (SELECT COUNT(*) FROM Trainer);
$$;

-- 5. Delete Member (Corrected Version)
CREATE OR REPLACE PROCEDURE delete_member(
    p_member_id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Delete dependent records first
    DELETE FROM Notification WHERE MemberId = p_member_id;
    DELETE FROM AttendanceTracker WHERE MemberId = p_member_id;
    DELETE FROM WorkoutPlan WHERE MemberId = p_member_id;
    DELETE FROM DietPlan WHERE MemberId = p_member_id;
    DELETE FROM PaymentIntegration WHERE MemberId = p_member_id;
    DELETE FROM SubscriptionPlan WHERE MemberId = p_member_id;
    
    -- Finally delete the member
    DELETE FROM Member WHERE Id = p_member_id;
END;
$$;