SELECT f1.user_id
FROM friends AS f1
JOIN friends AS f2
    ON f1.user_id = f2.user_id
WHERE f1.friend_id = (
    SELECT id FROM users WHERE username = 'lovelytrust487'
)
AND f2.friend_id = (
    SELECT id FROM users WHERE username = 'exceptionalinspiration482'
);
