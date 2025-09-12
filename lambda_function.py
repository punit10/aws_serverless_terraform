import random

sentences = [
    "The early bird catches the worm.",
    "Actions speak louder than words.",
    "A journey of a thousand miles begins with a single step.",
    "Fortune favors the bold.",
    "Practice makes perfect.",
    "Honesty is the best policy.",
    "Knowledge is power.",
    "Better late than never.",
    "Time waits for no one.",
    "When in Rome, do as the Romans do."
]


def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": random.choice(sentences)
    }
