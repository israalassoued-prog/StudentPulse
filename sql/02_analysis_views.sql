
-- StudentPulse
-- SQL Views for Business Intelligence Analysis

-- 1. Overall KPIs
CREATE OR REPLACE VIEW public.vw_overall_kpis AS
SELECT
    (SELECT COUNT(*) FROM students) AS total_students,
    (SELECT COUNT(*) FROM events) AS total_events,
    COUNT(*) AS total_registrations,
    COUNT(*) FILTER (
        WHERE attendance_status = 'Attended'
    ) AS total_attended,
    ROUND(
        COUNT(*) FILTER (WHERE attendance_status = 'Attended')::numeric
        * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS attendance_rate,
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction
FROM registrations;


-- 2. Performance by Event Category
CREATE OR REPLACE VIEW public.vw_category_performance AS
SELECT
    e.category,
    COUNT(r.registration_id) AS total_registrations,
    COUNT(*) FILTER (
        WHERE r.attendance_status = 'Attended'
    ) AS total_attended,
    ROUND(
        COUNT(*) FILTER (WHERE r.attendance_status = 'Attended')::numeric
        * 100.0 / NULLIF(COUNT(r.registration_id), 0),
        2
    ) AS attendance_rate,
    ROUND(AVG(r.satisfaction_score), 2) AS average_satisfaction
FROM events e
JOIN registrations r
    ON e.event_id = r.event_id
GROUP BY e.category;


-- 3. Performance by Event
CREATE OR REPLACE VIEW public.vw_event_performance AS
SELECT
    e.event_id,
    e.event_name,
    e.category,
    e.event_date,
    e.capacity,
    COUNT(r.registration_id) AS total_registrations,
    COUNT(*) FILTER (
        WHERE r.attendance_status = 'Attended'
    ) AS total_attended,
    ROUND(
        COUNT(r.registration_id)::numeric
        * 100.0 / NULLIF(e.capacity, 0),
        2
    ) AS capacity_utilization,
    ROUND(
        COUNT(*) FILTER (WHERE r.attendance_status = 'Attended')::numeric
        * 100.0 / NULLIF(COUNT(r.registration_id), 0),
        2
    ) AS attendance_rate,
    ROUND(AVG(r.satisfaction_score), 2) AS average_satisfaction
FROM events e
LEFT JOIN registrations r
    ON e.event_id = r.event_id
GROUP BY
    e.event_id,
    e.event_name,
    e.category,
    e.event_date,
    e.capacity;


-- 4. Performance by Registration Channel
CREATE OR REPLACE VIEW public.vw_channel_performance AS
SELECT
    registration_channel,
    COUNT(*) AS total_registrations,
    COUNT(*) FILTER (
        WHERE attendance_status = 'Attended'
    ) AS total_attended,
    ROUND(
        COUNT(*) FILTER (WHERE attendance_status = 'Attended')::numeric
        * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS attendance_rate,
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction
FROM registrations
GROUP BY registration_channel;


-- 5. Monthly Registration Trends
CREATE OR REPLACE VIEW public.vw_monthly_trends AS
SELECT
    DATE_TRUNC('month', registration_date)::date AS registration_month,
    COUNT(*) AS total_registrations,
    COUNT(*) FILTER (
        WHERE attendance_status = 'Attended'
    ) AS total_attended,
    ROUND(
        COUNT(*) FILTER (WHERE attendance_status = 'Attended')::numeric
        * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS attendance_rate
FROM registrations
GROUP BY DATE_TRUNC('month', registration_date);
