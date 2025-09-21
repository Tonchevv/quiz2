-- Sample data for Quiz App
-- Run this in Supabase SQL Editor

-- First, let's see what quizzes we have
SELECT id, title FROM public.quizzes;

-- Insert sample questions for the first quiz (replace with actual quiz ID)
-- You'll need to run this for each quiz ID you get from the above query

-- For Geography quiz (replace 'GEOGRAPHY_QUIZ_ID' with actual ID)
INSERT INTO public.questions (quiz_id, question_text, question_order, time_limit) VALUES
('GEOGRAPHY_QUIZ_ID', 'Коя е столицата на България?', 1, 30),
('GEOGRAPHY_QUIZ_ID', 'Кой е най-високият връх в България?', 2, 30),
('GEOGRAPHY_QUIZ_ID', 'Коя река минава през София?', 3, 30),
('GEOGRAPHY_QUIZ_ID', 'Кой е най-големият град в България след София?', 4, 30),
('GEOGRAPHY_QUIZ_ID', 'В коя планина се намира пещерата "Магура"?', 5, 30);

-- Get question IDs (run this after inserting questions)
SELECT id, question_text FROM public.questions WHERE quiz_id = 'GEOGRAPHY_QUIZ_ID';

-- Insert answers (replace question IDs with actual IDs from above query)
-- Question 1: Capital of Bulgaria
INSERT INTO public.answers (question_id, answer_text, is_correct, answer_order, color_code) VALUES
('Q1_ID', 'София', true, 1, 'red'),
('Q1_ID', 'Пловдив', false, 2, 'blue'),
('Q1_ID', 'Варна', false, 3, 'green'),
('Q1_ID', 'Бургас', false, 4, 'orange');

-- Question 2: Highest peak
INSERT INTO public.answers (question_id, answer_text, is_correct, answer_order, color_code) VALUES
('Q2_ID', 'Вихрен', false, 1, 'red'),
('Q2_ID', 'Мусала', true, 2, 'blue'),
('Q2_ID', 'Черни връх', false, 3, 'green'),
('Q2_ID', 'Ботев', false, 4, 'orange');

-- Question 3: River through Sofia
INSERT INTO public.answers (question_id, answer_text, is_correct, answer_order, color_code) VALUES
('Q3_ID', 'Дунав', false, 1, 'red'),
('Q3_ID', 'Марица', false, 2, 'blue'),
('Q3_ID', 'Искър', true, 3, 'green'),
('Q3_ID', 'Янтра', false, 4, 'orange');

-- Question 4: Second largest city
INSERT INTO public.answers (question_id, answer_text, is_correct, answer_order, color_code) VALUES
('Q4_ID', 'Пловдив', true, 1, 'red'),
('Q4_ID', 'Варна', false, 2, 'blue'),
('Q4_ID', 'Бургас', false, 3, 'green'),
('Q4_ID', 'Русе', false, 4, 'orange');

-- Question 5: Magura cave location
INSERT INTO public.answers (question_id, answer_text, is_correct, answer_order, color_code) VALUES
('Q5_ID', 'Рила', false, 1, 'red'),
('Q5_ID', 'Пирин', false, 2, 'blue'),
('Q5_ID', 'Беласица', false, 3, 'green'),
('Q5_ID', 'Стара планина', true, 4, 'orange');
