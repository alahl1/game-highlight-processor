import requests
import boto3
import os

API_URL = "https://free-football-soccer-videos.p.rapidapi.com"
HEADERS = {
    "X-Rapidapi-Host": "free-football-soccer-videos.p.rapidapi.com",
    "X-Rapidapi-Key": os.environ["RAPIDAPI_KEY"]
}

s3 = boto3.client("s3")
S3_BUCKET = os.environ["S3_BUCKET"]

def fetch_and_store_data():
    response = requests.get(API_URL, headers=HEADERS)
    if response.status_code == 200:
        data = response.json()
        for match in data:
            match_id = match["title"].replace(" ", "_")
            s3.put_object(
                Bucket=S3_BUCKET,
                Key=f"matches/{match_id}.json",
                Body=str(match)
            )
        print(f"Successfully stored {len(data)} matches")
    else:
        print(f"Failed to fetch data: {response.status_code}")

if __name__ == "__main__":
    fetch_and_store_data()
